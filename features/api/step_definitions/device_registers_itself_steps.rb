Given "I'm a Device with the following information:" do |device_info|
  info = device_info.hashes.first

  memorize_fact(
    :device_info,
    {
      serial_number: info['Serial Number'],
      firmware: info['Firmware Version']
    }
  )
end

Given "I'm not yet registered on the API" do
  expect(Device.all.count).to eql(0)
end

def device_info
  recall_fact(:device_info)
end

def post_json(path, data)
  header 'Accept', 'application/json'
  header 'Content-Type', 'application/json'
  post(path, JSON.dump(data))
end

When "I post my information to the registration endpoint" do
  set_response(post_json('/api/devices', {device: device_info}))
end

Then "I receive a valid response" do
  expect(response.status).to eql(200)
end

def json_body
  JSON.parse(response.body)
end

Then "the JSON body contains an authentication secret and registration date" do
  json_body.tap do |body|
    expect(body['device']['secret']).not_to be_nil
    expect(body['device']['created_at']).not_to be_nil
  end
end

Given "I am already registered on the API" do
  step %{I post my information to the registration endpoint}
  step %{I receive a valid response}

  memorize_fact(
    :registered_device,
    Device.find(serial_number: device_info[:serial_number]).first
  )
end

Then "I receive a 422 response" do
  expect(response.status).to eql(422)
end

Then "the JSON body reflects an error" do
  json_body.tap do |body|
    expect(body['device']['errors']).not_to be_nil
  end
end

Then "an alert is generated regarding the re-registration attempt" do
  device = Device.with_serial_number(device_info[:serial_number])
  expect(device.alerts.count).to eql(1)
end

Then "no changes are made to my credentials" do
  recall_fact(:registered_device).tap do |device|
    original_secret = device.crypted_secret
    current_secret = Device.
      find(serial_number: device.serial_number).
      first.
      crypted_secret

    expect(current_secret).to eql(original_secret)
  end
end
