require 'dry-transaction'
require_relative '../requirements'

module Hacefrio
  module Workflows
    class DeviceRegistration
      include Dry::Transaction(container: Requirements::Registry)
      include Requirements::Import[
        'storage.devices',
        'storage.alerts'
      ]

      step :decode, with: 'transform.decode.json'

      step :extract_device_info

      step :validate_serial_number,
        with: 'validation.serial_number_presence'

      step :validate_firmware,
        with: 'validation.firmware_presence'

      step :prevent_double_registration,
        with: 'validation.double_registration_prevention'

      step :persist_device

      private
      def extract_device_info(input)
        device = input.delete(:decoded)['device']

        if device
          Success(input.merge({device: device}))
        else
          Failure(:device_info_not_provided)
        end
      end

      def persist_device(input)
        attributes = input.delete(:device)
        secret = SecureRandom.hex(32)

        device = Device.new(
          serial_number: attributes['serial_number'],
          firmware: attributes['firmware'],
          crypted_secret: BCrypt::Password.create(secret)
        )

        if device.save
          Success(device: {created_at: device.created_at.utc.to_i, secret: secret})
        else
          Failure(:could_not_create_device)
        end
      end

    end
  end
end
