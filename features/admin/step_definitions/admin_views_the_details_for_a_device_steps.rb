Given "there is a Device" do
  memorize_fact(
    :device,
    Device.create(
      serial_number: SecureRandom.hex(16),
      firmware: '1.15.79'
    )
  )
end

Given "I am on the main dashboard" do
  visit('/')
  login(email, password)
end

def device
  recall_fact(:device)
end

When "I browse to the existing device" do
  find_link(device.serial_number).click
end

Then "I land on the details page for that device" do
  expect(page).
    to have_current_path(
      "/devices/#{device.serial_number}"
  )
end

Given "the Device has sent at least one update" do
  updates = JSON.dump(
    {
      updates: [
        {
          temp: 32.0,
          humidity: 15.0,
          co: 1.0,
          status: 'DIAF'
        }
      ]
    }
  )

  workflow = Hacefrio::Workflows::DeviceUpdates.new

  result = workflow.call(device_id: device.id, json: updates).to_result
  expect(result.success?).to eql(true)
end

When "I browse to the device's details page" do
  step %{I am on the main dashboard}
  step %{I browse to the existing device}
end

Then "I see its serial, firmware, and registration date" do
  expect(page).to have_content(device.serial_number)
  expect(page).to have_content(device.firmware)
  expect(page).to have_content(device.created_at)
end

def detect_latest(sensor)
  value = Sensor.
    find(device_id: device.id, sensor_name: sensor).
    sort(reported_at: 'DESC').
    first.
    value

  within("##{sensor}") do
    expect(page).to have_content(value)
  end
end

Then "I see its most recent temperature reading" do
  detect_latest('temp')
end

Then "I see its most recent air humidity reading" do
  detect_latest('humidity')
end

Then "I see its most recent carbon monoxide level reading" do
  detect_latest('co')
end

Then "I see its most recent health status" do
  detect_latest('status')
end

Given "the Device has not sent any updates" do
  Sensor.find(device_id: device.id).map(&:destroy)
end

Then "I'm advised that there is no sensor data to show" do
  %w[temp humidity co status].each do |sensor|
    within("##{sensor}") do
      expect(page).to have_content("No Recorded Value")
    end
  end
end
