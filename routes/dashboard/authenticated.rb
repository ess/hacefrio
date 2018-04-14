module Dashboard
  module Authenticated
    App = Syro.new(Deck) do
      @current_admin = authenticated(Admin)

      get do
        page[:title] = 'Devices'
        render("views/authenticated/devices/index.mote")
      end

    end
  end
end
