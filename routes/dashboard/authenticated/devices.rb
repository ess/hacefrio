module Dashboard
  module Authenticated
    Devices = Syro.new(Deck) do
      get do
        page[:title] = 'Devices'
        render("views/authenticated/devices/index.mote", devices: devices.all)
      end

    end
  end
end
