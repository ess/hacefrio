require_relative 'authenticated/devices'

module Dashboard
  module Authenticated
    App = Syro.new(Deck) do
      @current_admin = authenticated(Admin)

      on 'login' do
        res.redirect '/'
      end

      run(Devices)
    end
  end
end
