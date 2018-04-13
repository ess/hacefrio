def secret
  'supersekrat'
end

Given "I'm a registered Device" do
  device_info = memorize_fact(
    :device_info,
    {
      serial_number: '1a2bc3',
      firmware: '5.4.1',
      crypted_secret: BCrypt::Password.create(secret)
    }
  )

  Device.create(device_info)
end

Given "I have the following updates to send:" do |updates|
  memorize_fact(
    :updates,
    updates.hashes.map {|update|
      {
        at: update['Timestamp'],
        temp: update['Temp'],
        humidity: update['Humidity'],
        co: update['CO Level'],
        status: update['Status']
      }
    }
  )
end

def authenticated_post(path, body)
  device = recall_fact(:device_info)

  header 'Authorization', "#{device[:serial_number]}:#{secret}"
  post_json(path, body)
end

When "I post my JSON payload to the updates endpoint" do
  set_response(authenticated_post('/api/updates', {updates: recall_fact(:updates)}))
end

Then "I'm advised that the update succeeded" do
  expect(response.status).to eql(200)
end

Then "each of the provided sensors is recorded" do
  updates = recall_fact(:updates)

  updates.each do |update|
    reported_at = update[:at].to_i

    [:temp, :humidity, :co, :status].each do |metric|
      sensor = Sensor.find(
        reported_at: reported_at,
        sensor_name: metric.to_s
      ).first

      expect(sensor).not_to be_nil
      expect(sensor.value).to eql(update[metric].to_s)
    end
  end
end

When "I post an empty JSON payload to the updates endpoint" do
  set_response(authenticated_post('/api/updates', {updates: []}))
end

Then "no new sensors are recorded" do
  expect(Sensor.all.count).to eql(0)
end

Then "an alert is generated regarding the empty update" do
  expect(Alert.all.count).to eql(1)
end

Given "I'm an unregistered device" do
  Device.
    find(serial_number: recall_fact(:device_info)[:serial_number]).
    first.
    delete
end

Then "I'm advised that I'm not authorized to use the endpoint" do
  expect(response.status).to eql(401)
end

Then "an alert is generated regarding the failed authentication attempt" do
  expect(Alert.all.count).to eql(1)
end
