require 'dry/transaction/operation'

module Hacefrio
  module Requirements
    module Operations
      module Validations

        class DoubleRegistrationPrevention
          include Dry::Transaction::Operation

          def call(input)
            serial_number = input[:device]['serial_number']

            d = devices.with_serial_number(serial_number)

            if d
              alerts.create(
                severity: 'WARNING',
                message: "Device #{serial_number} attempted a repeat registration.",
                device_id: d.id
              )

              Failure(:duplicate_registration)
            else
              Success(input)
            end
          end

          private
          def devices
            Registry.resolve('storage.devices')
          end

          def alerts
            Registry.resolve('storage.alerts')
          end

        end

      end
    end
  end
end
