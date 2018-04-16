Given "that Device has updated once per day for the last year" do
  Timecop.freeze(Time.now)

  offset = 60 * 60 * 24
  current = Time.now.utc.to_i

  workflow = Hacefrio::Workflows::DeviceUpdates.new

  updates = (0..366).map {|day|
    {
      at: current - (day * offset),
      temp: rand(100),
      humidity: rand(100),
      co: rand(8),
      status: ['Okay', 'Error'].sample
    }
  }
  
  result = workflow.
    call(device_id: device.id, json: {updates: updates}.to_json).to_result

  expect(result.success?).to eql(true)
end

Given "I'm viewing the details page for the device" do
  step %{I browse to the device's details page}
end

def normalized_sensor_name(sensor)
  case sensor
  when 'temperature'
    'temp'
  when 'air humidity'
    'humidity'
  when 'carbon monoxide level'
    'co'
  when 'health status'
    'status'
  else
    sensor
  end
end

When %r(^I click on the current (.+) reading$) do |sensor_name|
  sensor_name = normalized_sensor_name(sensor_name)
  find_link("#{sensor_name}-history").click
end

Then %r(^I land on the details page for the device's (.+) sensor$) do |sensor_name|
  sensor_name = normalized_sensor_name(sensor_name)

  expect(page).
    to have_current_path(
      "/devices/#{device.serial_number}/sensors/#{sensor_name}/daily"
    )
end

Then "I'm advised that I'm seeing the readings for the last day" do
  expect(page).to have_content("Current view: Daily")
end

Then "I see an option to view the last week's readings" do
  expect(page).to have_selector('#weekly')
end

Then "I see an option to view the last month's readings" do
  expect(page).to have_selector('#monthly')
end

Then "I see an option to view the last year's readings" do
  expect(page).to have_selector('#yearly')
end

def timespan_selector(timespan)
  timespan == 'day' ? 'daily' : timespan + 'ly'
end

Given %r(^I'm viewing the last (.+)'s details for the device's (.+) sensor$) do |timespan, sensor_name|
  step %{I'm viewing the details page for the device}
  step %{I click on the current #{sensor_name} reading}

  find_link(timespan_selector(timespan)).click
end

def timespan_offset(timespan)
  magnitude = 24 * case timespan
                   when '7 days'
                     7
                   when '30 days'
                     30
                   when '365 days'
                     365
                   else
                     1
                   end
  
  3600 * magnitude
end

Then %r(^I see only the (.+) readings within the last (.+)$) do |sensor_name, timespan|
  all_sensors = Sensor.
    find(
      device_id: device.id, sensor_name: normalized_sensor_name(sensor_name)
    ).
    to_a

  now = Time.now.utc.to_i
  cutoff = now - timespan_offset(timespan)

  all_sensors.each do |sensor|
    selector = "#sensor-#{sensor.id}"

    if sensor.reported_at.to_i >= cutoff
      expect(page).to have_selector(selector)
    else
      expect(page).not_to have_selector(selector)
    end
  end
end
