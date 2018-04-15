class Device < Ohm::Model
  include Ohm::Timestamps

  attribute :serial_number
  attribute :firmware
  attribute :crypted_secret
  collection :alerts, :Alert
  collection :sensors, :Sensor

  index :serial_number
  unique :serial_number

  def self.with_serial_number(serial_number)
    find(serial_number: serial_number).first
  end

  def registered_at
    Time.at(created_at).utc
  end

  def latest_temp
    latest_reading_for('temp')
  end

  def latest_humidity
    latest_reading_for('humidity')
  end

  def latest_co
    latest_reading_for('co')
  end

  def latest_status
    latest_reading_for('status')
  end

  def latest_reading_for(sensor_name)
    sensor = sensors.
      find(sensor_name: sensor_name).
      sort(reported_at: 'DESC').
      first

    sensor.nil? ? 'No Recorded Value' : sensor.value
  end
end
