require 'uri'

Given "I'm an Admin with invalid credentials" do
  step %{I'm an Admin with valid credentials}

  admin = Admin.all.first
  memorize_fact(:my_email, admin.email)
  crypted = admin.crypted_password
  admin.password = SecureRandom.hex(16)
  admin.save

  expect(admin.crypted_password).not_to eql(crypted)
end

When "I click the forgotten password link" do
  find_link('Forgot password?').click
end

When "I provide my email address" do
  within('#reset') do
    fill_in('email', with: recall_fact(:my_email))
    find_button("Reset").click
  end
end

Then "I'm advised to check my email" do
  expect(page).
    to have_content("Please check your email for further instructions")
end

Then "I receive a password reset email" do
  reset_message = Malone.deliveries.find {|message| message.to == recall_fact(:my_email) && message.subject = 'Password Reset'}

  expect(reset_message).not_to be_nil

  memorize_fact(:reset_message, reset_message)
end

Given "I've received a password reset email" do
  visit '/reset'
  step %{I provide my email address}
  step %{I receive a password reset email}
end

When "I follow the password reset link in the email" do
  url = recall_fact(:reset_message).
    text.
    gsub("Visit ", 'http://').
    gsub(' to reset your password.', '').
    chomp

  visit URI.parse(url).path
end

Then "I land on the password reset page" do
  true
end

When "I provide a confirmed password" do
  within('#update') do
    fill_in('password', with: 'owa tagoo siam')
    find_button('Update').click
  end
end
