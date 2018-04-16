require 'dry-transaction'
require_relative '../requirements'

module Hacefrio
  module Workflows
    class DeviceLookup
      include Dry::Transaction
      include Requirements::Import[
        'storage.devices',
      ]

      NOT_FOUND = :device_not_found

      step :verify_input
      step :find_device

      private
      def verify_input(input)
        input.keys.include?(:serial_number) ?
          Success(input) :
          Failure(NOT_FOUND)
      end

      def find_device(input)
        device = devices.find(serial_number: input[:serial_number]).first

        device.nil? ? Failure(NOT_FOUND) : Success(device)
      end
    end
  end
end
