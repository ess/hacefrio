module API
  class Deck < Syro::Deck
    def default_headers
      { Rack::CONTENT_TYPE => "application/json"}
    end

    def api_error(status, body)
      res.status = status
      res.json(JSON.dump(body))
    end
  end
end
