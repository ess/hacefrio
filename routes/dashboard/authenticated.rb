require_relative 'authenticated/devices'

module Dashboard
  module Authenticated
    App = Syro.new(Deck) do
      @current_admin = authenticated(Admin)

      run(Devices)
    end
  end
end
