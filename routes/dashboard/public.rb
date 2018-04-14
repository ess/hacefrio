require_relative 'public/login'

module Dashboard
  module Public
    App = Syro.new(Deck) do

      # Require logins
      get do
        res.redirect '/login'
      end

      on "login" do
        run(Login)
      end
    end
  end
end
