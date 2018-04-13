require 'dry/transaction/operation'

module Hacefrio
  module Requirements
    module Operations
      module Validations

        class SerialNumberPresence
          include Dry::Transaction::Operation

          def call(input)
            if input[:device]['serial_number']
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
