module Dashboard
  module Authenticated
    Devices = Syro.new(Deck) do
      get do
        page[:title] = 'Devices'
        render("views/authenticated/devices/index.mote", devices: devices.all)
      end

      on 'devices' do
        on :serial_number do
          device_finder.call(serial_number: inbox[:serial_number]) do |m|
            m.success do |device|

              on "sensors" do

                on :sensor do
                  on :timespan do
                    get do
                      display_name = case inbox[:sensor]
                                    when 'temp'
                                      'Temperature'
                                    when 'humidity'
                                      'Air Humidity'
                                    when 'co'
                                      'Carbon Monoxide Level'
                                    when 'status'
                                      'Health Status'
                                    end

                      page[:title] = "#{display_name} History for Device #{device.serial_number}"
                      timespan = inbox[:timespan]

                      display_timespan = case timespan
                                         when 'daily'
                                           'Daily'
                                         when 'weekly'
                                           'Weekly'
                                         when 'monthly'
                                           'Monthly'
                                         when 'yearly'
                                           'Yearly'
                                         end

                      sensors = sensor_finder.
                        call(
                          device_id: device.id,
                          timespan: timespan,
                          sensor_name: inbox[:sensor]
                        ).value!

                      render(
                        'views/authenticated/sensors/show.mote',
                        sensors: sensors,
                        device: device,
                        sensor_name: inbox[:sensor],
                        heading: page[:title],
                        timespan: display_timespan
                      )

                    end
                  end

                  get do
                    res.redirect "#{inbox[:sensor]}/daily"
                  end

                end

              end

              get do
                page[:title] = "Device #{device.serial_number}"

                render("views/authenticated/devices/show.mote", device: device)
              end
            end

            m.failure do
              res.status = 404
            end
          end


        end
      end

    end
  end
end
