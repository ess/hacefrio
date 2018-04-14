module Dashboard
  module Public
    Login = Syro.new(Deck) do
      page[:title] = 'Please Sign In'
      @login_template = 'views/public/login.mote'

      get do
        render(@login_template)
      end

      post do
        on login(Admin, req[:email], req[:password]) != nil do
          remember

          res.redirect "/"
        end

        session[:alert] = 'Invalid Login'

        render(@login_template)
      end
    end
  end
end
