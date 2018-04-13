require 'bcrypt'

module API
  class Deck < Syro::Deck
    def default_headers
      { Rack::CONTENT_TYPE => "application/json"}
    end

    def api_error(status, body)
      res.status = status
      render(body)
    end

    def render(body)
      res.json(JSON.dump(body))
    end

    def unauthorized(serial = nil)
      if serial
        Alert.create(
          severity: 'WARNING',
          message: "Device #{serial} failed to authenticate.",
        )
      end

      api_error(401, {error: 'You are not authorized to use this API'})
      false
    end

    def authenticated
      auth = req.get_header('HTTP_AUTHORIZATION')
      return unauthorized if auth.nil?

      serial_number, secret = auth.split(':')

      device = Device.find(serial_number: serial_number).first
      if device.nil? || !(BCrypt::Password.new(device.crypted_secret) == secret)
        return unauthorized(serial_number)
      end

      set_current_device(device)
      true
    end

    def set_current_device(device)
      @current_device = device
    end

    def current_device
      @current_device ||= device
    end
  end
end
