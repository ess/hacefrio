Given "there is 1 other blocked Admin" do
  memorize_fact(:other_admin, Admin.create(
    email: 'victim@example.com',
    password: 'whatever',
    blocked: true
  ))
end

Then "that Admin is unblocked" do
  expect(Admin[recall_fact(:other_admin).id].blocked).to eql(false)
end

Then "they receive an email indicating that they have been unblocked" do
  victim = recall_fact(:other_admin)

  blessed_email = Malone.deliveries.find {|message|
    message.to == victim.email && message.subject == 'Account Reactivated'
  }

  expect(blessed_email).not_to be_nil
end
