require 'json'
require_relative 'dashboard/deck'
require_relative 'dashboard/public'
require_relative 'dashboard/authenticated'

module Dashboard
  App = Syro.new(Deck) do
    authenticated(Admin) ? run(Authenticated::App) : run(Public::App)
  end
end
