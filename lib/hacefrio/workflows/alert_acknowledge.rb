require 'dry-transaction'
require_relative '../requirements'

module Hacefrio
  module Workflows
    class AlertAcknowledge
      include Dry::Transaction
      include Requirements::Import[
        'storage.alerts',
      ]

      step :delete_alert

      private
      def delete_alert(input)
        alert = Alert[input[:id]]
        unless alert.nil?
          alert.delete
        end

        Success(true)
      end
    end
  end
end
