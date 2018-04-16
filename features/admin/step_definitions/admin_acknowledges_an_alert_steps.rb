Given "there's an Alert" do
  Alert.create(
    severity: 'WARN',
    message: memorize_fact(:alert_message, 'My sausages turned to gold!')
  )
end

When "I browse to the Alerts page" do
  find_link('Alerts').click
end

Then "I see all current alerts" do
  expect(page).to have_content(recall_fact(:alert_message))
end

Given "I'm on the Alerts page" do
  step "I'm using the dashboard"
  step "I browse to the Alerts page"
end

When "I click the acknowledge button for an alert" do
  alert = Alert.all.first

  find_button("ack-#{alert.id}").click
end

Then "I land on the Alerts page" do
  expect(page).to have_current_path('/alerts')
end

Then "that alert is no longer present" do
  expect(page).not_to have_content(recall_fact(:alert_message))
end
