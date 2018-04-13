require 'dry-transaction'
require_relative '../requirements'

module Hacefrio
  module Workflows
    class DeviceUpdates
      include Dry::Transaction(container: Requirements::Registry)
      include Requirements::Import[
        'storage.devices',
        'storage.alerts',
        'storage.sensors',
      ]

      step :decode, with: 'transform.decode.json'
      step :extract_updates
      step :warn_on_empty_payload
      step :persist_temperatures
      step :persist_humidities
      step :persist_co_levels
      step :persist_health_statuses
      step :report_success

      private
      def extract_updates(input)
        Success(updates: input[:decoded]['updates'])
      end

      def warn_on_empty_payload(input)
        if input[:updates].nil? || !input[:updates].is_a?(Array) || input[:updates].empty?

          alerts.create(
            severity: 'WARNING',
            message: "Device FIXME provided an empty update.",
          )

          Failure(:empty_update)
        else
          Success(input)
        end

      end

      def persist_temperatures(input)
        input[:updates].each do |update|
          if update['temp']
            sensors.create(
              reported_at: update['at'].to_i,
              sensor_name: 'temp',
              value: update['temp'],
              device_id: input[:device_id]
            )
          end
        end

        Success(input)
      end

      def persist_humidities(input)
        input[:updates].each do |update|
          if update['humidity']
            sensors.create(
              reported_at: update['at'].to_i,
              sensor_name: 'humidity',
              value: update['humidity'],
              device_id: input[:device_id]
            )
          end
        end

        Success(input)
      end

      def persist_co_levels(input)
        input[:updates].each do |update|
          if update['co']
            sensors.create(
              reported_at: update['at'].to_i,
              sensor_name: 'co',
              value: update['co'],
              device_id: input[:device_id]
            )
          end
        end

        Success(input)
      end

      def persist_health_statuses(input)
        input[:updates].each do |update|
          if update['status']
            sensors.create(
              reported_at: update['at'].to_i,
              sensor_name: 'status',
              value: update['status'],
              device_id: input[:device_id]
            )
          end
        end

        Success(input)
      end

      def report_success(input)
        Success({update: {status: 'success'}})
      end
    end
  end
end
