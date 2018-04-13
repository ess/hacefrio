require 'dotenv/load'
require 'syro'
require 'ohm'
require 'ohm/contrib'
require 'redic'

Ohm.redis = Redic.new(ENV['REDIS_URL'])

# Load everything up
PIECES = "./{lib,apps,models}/*.rb"
Dir[PIECES].each {|file| require file}

App = Syro.new do
  on "api" do
    run(API::App)
  end
end
