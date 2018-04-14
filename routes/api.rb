require 'json'
require_relative 'api/deck'
require_relative 'api/devices'
require_relative 'api/updates'

module API
  App = Syro.new(Deck) do
    on "devices" do
      run(Devices)
    end

    on "updates" do
      run(Updates)
    end
  end
end
