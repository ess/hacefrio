require_relative 'authenticated/admins'
require_relative 'authenticated/alerts'
require_relative 'authenticated/devices'

module Dashboard
  module Authenticated
    App = Syro.new(Deck) do
      on authenticated(Admin).blocked do
        default do
          res.status = 403
        end
      end

      on 'login' do
        res.redirect '/'
      end

      on 'logout' do
        get do
          logout(Admin)

          res.redirect '/'
        end
      end

      on "admins" do
        run(Admins)
      end

      on "alerts" do
        run(Alerts)
      end

      run(Devices)
    end
  end
end
