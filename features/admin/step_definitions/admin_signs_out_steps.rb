When "I click on the signout button" do
  find_link('Sign Out').click
end

Then "I am no longer signed in" do
  expect(page).not_to have_content('Sign Out')
end
