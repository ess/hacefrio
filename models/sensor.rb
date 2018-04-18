class Sensor < Ohm::Model
  include Ohm::Timestamps
  include Ohm::DataTypes

  attribute :reported_at, Type::Integer
  attribute :sensor_name
  attribute :value

  reference :device, :Device

  index :reported_at
  index :sensor_name

  def display_value
    value.to_s + case sensor_name
    when 'temp'
      "&deg;C"
    when 'humidity'
      "%"
    when 'co'
      ' PPM'
    else
      ''
    end
  end
end
