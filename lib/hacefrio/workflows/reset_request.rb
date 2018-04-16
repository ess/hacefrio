require 'dry-transaction'
require_relative '../requirements'

module Hacefrio
  module Workflows
    class ResetRequest
      include Dry::Transaction
      include Requirements::Import[
        'storage.admins',
      ]

      private
    end
  end
end
