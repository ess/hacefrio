Given "I'm using the dashboard" do
  step %{I am viewing any part of the dashboard}
end

When "the device reports a dangerous carbon monoxide level" do
  # This is kinda janky. We have to examine the page contents before the
  # alert gets created so Capybara will have a record of us not seeing
  # the alert before we're supposed to.
  page.html

  updates = JSON.dump(
    {
      updates: [
        {
          co: 9.0,
        }
      ]
    }
  )

  workflow = Hacefrio::Workflows::DeviceUpdates.new

  result = workflow.call(device_id: device.id, json: updates).to_result
  expect(result.success?).to eql(true)
end

Then "I do not immediately see the alert" do
  expect(page).not_to have_selector('.crit')
end

When "I refresh the page" do
  page.refresh
end

Then "I see that there are unacknowledged critical alerts" do
  expect(page).to have_selector('.crit')
end

When "I click on the notification" do
  find_link('alert-notice').click
end

Then "I land on the alerts list" do
  expect(page).to have_current_path("/alerts")
end

Then "I see the dangerous carbon monoxide level alert" do
  expect(page).to have_content('High CO Level')
end

Given "I'm not signed in" do
  true
end
