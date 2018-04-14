require 'dotenv/load'
require 'syro'
require 'ohm'
require 'ohm/contrib'
require 'redic'
require 'shield'
require 'mote'
require 'tas'
require 'hache'

Ohm.redis = Redic.new(ENV['REDIS_URL'])

# Load everything up
PIECES = "./{lib,routes,models}/*.rb"
Dir[PIECES].each {|file| require file}

Wrapp = Syro.new do
  on "api" do
    run(API::App)
  end

  run(Dashboard::App)
end

App = Rack::Builder.new do
  use Rack::MethodOverride
  use Rack::Session::Cookie, secret: ENV['SECRET']
  use Rack::Static, urls: %w[/css /fonts /img], root: './public'

  run(Wrapp)
end
