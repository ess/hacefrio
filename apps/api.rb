require 'json'
require_relative 'api/deck'
require_relative 'api/devices'

module API
  App = Syro.new(Deck) do
    on "devices" do
      run(Devices)
    end
  end
end
