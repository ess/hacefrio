require 'dry-transaction'
require_relative '../requirements'

module Hacefrio
  module Workflows
    class AccountToggle
      include Mote::Helpers
      include Dry::Transaction
      include Requirements::Import[
        'storage.admins',
        'services.mailer',
      ]

      step :find_admin
      step :toggle_blocked_state
      step :notify_of_change

      private
      def find_admin(input)
        id = input.delete(:id)

        admin = admins[id]

        admin.nil? ? Failure(:not_found) : Success(input.merge(admin: admin))
      end

      def toggle_blocked_state(input)
        admin = input.delete(:admin)

        admin.update(blocked: admin.blocked ? false : true)

        Success(input.merge(admin: admin))
      end

      def notify_of_change(input)
        admin = input.delete(:admin)

        mailer.deliver(
          to: admin.email,
          subject: subject(admin),
          text: mote(template(admin))
        )

        Success(true)
      end

      def template(admin)
        "mails/#{admin.blocked ? 'blocked' : 'blessed'}.mote"
      end

      def subject(admin)
        "Account #{admin.blocked ? 'Suspended' : 'Reactivated'}"
      end

    end
  end
end
