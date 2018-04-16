Given "I'm not an Admin" do
  true
end

When "an Admin invites me to become one" do
  step %{I'm an Admin with valid credentials}
  step %{I'm using the dashboard}
  
  visit "/admins/new"

  step %{I submit the collaborator's email address}
  step %{I click on the signout button}
end

Then "I receive an invitation email" do
  step %{the Collaborator receives an invitation email}
end

Then "I follow the RSVP link in the email" do
  url = recall_fact(:invitation).
    text.
    gsub("Visit ", 'http://').
    gsub(' to activate your account.', '').
    chomp

  visit URI.parse(url).path
end

Then "I land on the account creation page" do
  true
end

When "I submit a confirmed password" do
  within('#activate') do
    fill_in(:password, with: 'supersekrat')
    find_button('Activate').click
  end
end

Then "I become an Admin" do
  step "I am signed in"
end
