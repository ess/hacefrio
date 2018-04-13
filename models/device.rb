class Device < Ohm::Model
  include Ohm::Timestamps

  attribute :serial_number
  attribute :firmware
  attribute :crypted_secret
  collection :alerts, :Alert

  index :serial_number
  unique :serial_number

  def self.with_serial_number(serial_number)
    find(serial_number: serial_number).first
  end
end
