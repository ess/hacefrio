class Alert < Ohm::Model
  include Ohm::Timestamps

  attribute :severity
  attribute :message

  reference :device, :Device
  index :severity

  def reported_at
    Time.at(created_at).utc
  end

  def display_device
    device_id.nil? ? 'None' : device.serial_number
  end
end
