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


      on "reset" do
        get do
          render("views/public/reset.mote")
        end

        post do
          @user = Admin.fetch(req[:email])

          on @user != nil do
            Gatekeeper.reset(@user)

            session[:alert] = "Please check your email for further instructions"

            res.redirect "/login"
          end

          default do
            session[:alert] = "Invalid email"

            render("views/public/reset.mote")
          end
        end

        on :token do
          @user = Admin[Gatekeeper.decode(inbox[:token])]

          on @user != nil do
            get do
              render("views/public/update.mote")
            end

            post do
              on req[:password] != nil do
                @user.update(password: req[:password])

                authenticate(@user)

                session[:alert] = "Password updated"

                res.redirect "/"
              end

              default do
                session[:alert] = "Invalid password"

                render("views/public/update.mote")
              end
            end
          end

          default do
            session[:alert] = "Invalid or expired URL"

            res.redirect "/reset"
          end
        end
      end
    end
  end
end
