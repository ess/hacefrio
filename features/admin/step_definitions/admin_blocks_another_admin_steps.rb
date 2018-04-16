Given "there is 1 other active Admin" do
  memorize_fact(:other_admin, Admin.create(
    email: 'nemesis@example.com',
    password: 'whatever'
  ))
end

Given "I'm on the Admin list" do
  step %{I'm using the dashboard}
  step %{I browse to the Admins page}
end

When "I click on the other Admin's status" do
  nemesis = recall_fact(:other_admin)

  within("#admin-#{nemesis.id}") do
    find_link('toggle').click
  end
end

Then "that Admin is blocked" do
  expect(Admin[recall_fact(:other_admin).id].blocked).to eql(true)
end

Then "they receive an email indicating that they have been blocked" do
  nemesis = recall_fact(:other_admin)

  blocked_email = Malone.deliveries.find {|message|
    message.to == nemesis.email && message.subject == 'Account Suspended'
  }

  expect(blocked_email).not_to be_nil
end

Given "I'm on the main dashboard" do
  step %{I'm using the dashboard}
end

When "the other Admin blocks me" do
  me = Admin.find(email: recall_fact(:email)).first

  me.update(blocked: true)
end

Then "nothing immediately happens" do
  true
end

Then "I am signed out" do
  step "I am no longer signed in"
end

Then "I am advised that I have been blocked" do
  expect(page).to have_content('Your account has been suspended')
end

Given "I've been blocked" do
  step %{the other Admin blocks me}
end

When "I attempt to sign in" do
  step %{I'm using the dashboard}
end
