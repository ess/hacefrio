module API
  Devices = Syro.new(Deck) do
    post do
      workflow = Hacefrio::Workflows::DeviceRegistration.new

      workflow.call(json: req.body.read) do |match|
        match.success do |payload|
          res.json(JSON.dump(payload))
        end

        match.failure do |error|
          api_error(422, {device: {errors: ["You can only register once"]}})
        end
      end

    end
  end
end
