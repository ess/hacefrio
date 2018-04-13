require 'dry/transaction/operation'

module Hacefrio
  module Requirements
    module Operations
      module Validations

        class FirmwarePresence
          include Dry::Transaction::Operation

          def call(input)
            if input[:device]['firmware']
              Success(input)
            else
              Failure(:no_serial_number)
            end
          end
        end

      end
    end
  end
end
