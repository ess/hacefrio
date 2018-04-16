When "I click on the Invite a Collaborator button" do
  find_link('invite').click
end

Then "I land on the invitation creator" do
  expect(page).to have_current_path("/admins/new")
end

When "I submit the collaborator's email address" do
  puts page.html
  within('#new-admin') do
    fill_in('email', with: memorize_fact(:new_admin, 'newuser@example.com'))
    find_button('Invite').click
  end
end

Then "I land on the Admin list" do
  expect(page).to have_current_path('/admins')
end

Then "I'm advised that my invitation has been sent" do
  expect(page).to have_content("The invitation is on its way.")
end

Then "the Collaborator receives an invitation email" do
  invitation = Malone.
    deliveries.
    find {|delivery|
      delivery.to == recall_fact(:new_admin) &&
        delivery.subject == "You're invited to Hacefrio!"
    }

  expect(invitation).not_to be_nil
end
