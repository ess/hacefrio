module Dashboard
  module Authenticated
    Devices = Syro.new(Deck) do
      get do
        page[:title] = 'Devices'
        render("views/authenticated/devices/index.mote", devices: devices.all)
      end

      on 'devices' do
        on :serial_number do
          get do
            devices.with_serial_number(inbox[:serial_number]).tap do |device|
              if device
                page[:title] = "Device #{device.serial_number}"

                render("views/authenticated/devices/show.mote", device: device)
              else
                res.status = 404
              end
            end
          end
        end
      end

    end
  end
end
