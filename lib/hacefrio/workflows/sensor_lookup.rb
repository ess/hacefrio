require 'dry-transaction'
require_relative '../requirements'

module Hacefrio
  module Workflows
    class SensorLookup
      include Dry::Transaction(container: Requirements::Registry)
      include Requirements::Import[
        'storage.sensors'
      ]

      step :calculate_offset
      step :find_sensors

      private
      def calculate_offset(input)
        magnitude = 24 * case input.delete(:timespan)
                    when 'weekly'
                      7
                    when 'monthly'
                      30
                    when 'yearly'
                      365
                    else
                      1
                    end

        offset = Time.now.utc.to_i - (3600 * magnitude)

        Success(input.merge(offset: offset))
      end

      def find_sensors(input)
        device_id = input.delete(:device_id)
        offset = input.delete(:offset)
        sensor_name = input.delete(:sensor_name)

        collection = sensors.
          find(device_id: device_id, sensor_name: sensor_name).
          sort(reported_at: 'DESC').
          reject {|sensor| sensor.reported_at < offset}

        Success(collection)
      end
    end
  end
end
