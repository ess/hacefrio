def email
  recall_fact(:email)
end

def password
  recall_fact(:password)
end

Given "I'm an Admin with valid credentials" do
  memorize_fact(:email, 'user@example.com')
  memorize_fact(:password, 'supersekrat')

  Admin.create(email: email, password: password)
end

Given "I am not signed in" do
end

When "I visit the web app" do
  visit '/'
end

Then "I see the sign in page" do
  expect(page).to have_current_path('/login')
end

Given "I'm on the sign in page" do
  visit '/login'
end

def login(identity, auth)
  fill_in('email', with: identity)
  fill_in('password', with: auth)
  find_button('Login').click
end

When "I provide my login credentials" do
  login(email, password)
end

Then "I land on the main dashboard" do
  expect(page).to have_current_path('/')
end

Then "I am signed in" do
  expect(page).to have_content('Sign Out')
end

When "I provide invalid login credentials" do
  login('scroob@spaceballs.com', '12345')
end

Then "I land on the sign in page" do
  step %{I see the sign in page}
end

Then "I'm advised that my sign in attempt was unsuccessful" do
  expect(page).to have_content('Invalid Login')
end

