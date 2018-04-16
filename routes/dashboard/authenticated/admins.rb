module Dashboard
  module Authenticated
    Admins = Syro.new(Deck) do
      get do
        page[:title] = 'Alerts'
        render(
          "views/authenticated/admins/index.mote",
          admins: admins.all.sort(email: 'ASC')
        )
      end

      on 'new' do
        get do
          page[:title] = 'Invite a Collaborator'

          render('views/authenticated/admins/new.mote')
        end

        post do
          email = req[:email]

          admin = admins.create(email: email, password: SecureRandom.hex(32))
          
          Gatekeeper.invite(admin)

          session[:alert] = 'The invitation is on its way'

          res.redirect '/admins'
        end
      end

      on :id do
        on 'toggle' do
          blocker.call(id: inbox[:id]).to_result

          res.redirect '/admins'
        end
      end

    end
  end
end
