module API
  Updates = Syro.new(Deck) do
    on(authenticated) do
      post do
        workflow = Hacefrio::Workflows::DeviceUpdates.new

        workflow.call(
          device_id: current_device.id, json: req.body.read
        ) do |match|
          match.success do
            render({update: 'success'})
          end

          match.failure do
            render({update: 'success'})
          end
        end
      end
    end
  end
end
