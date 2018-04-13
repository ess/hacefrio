class Sensor < Ohm::Model
  include Ohm::Timestamps
  include Ohm::DataTypes

  attribute :reported_at, Type::Integer
  attribute :sensor_name
  attribute :value

  reference :device, :Device

  index :reported_at
  index :sensor_name
end
