require 'json'
require 'dry/transaction/operation'

module Hacefrio
  module Requirements
    module Operations
      module Transforms

        class DecodeJSON
          include Dry::Transaction::Operation

          def call(input)
            blob = input.delete(:json)

            begin
              Success(input.merge({decoded: JSON.load(blob)}))
            rescue => e
              Failure(:invalid_json)
            end
          end
        end

      end
    end
  end
end
