require 'dry-container'
require 'dry-auto_inject'
require_relative 'requirements/operations'

module Hacefrio
  module Requirements
    module Registry
      extend Dry::Container::Mixin

      namespace('storage') do
        register('devices') {Device}
        register('alerts') {Alert}
        register('sensors') {Sensor}
      end

      namespace('transform') do
        namespace('decode') do
          register('json') {Operations::Transforms::DecodeJSON.new}
        end
      end

      namespace('validation') do
        register('double_registration_prevention') {
          Operations::Validations::DoubleRegistrationPrevention.new
        }

        register('firmware_presence') {
          Operations::Validations::FirmwarePresence.new
        }

        register('serial_number_presence') {
          Operations::Validations::SerialNumberPresence.new
        }

      end
    end

    Import = Dry::AutoInject(Registry)
  end
end
