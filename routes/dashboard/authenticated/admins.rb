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

      on :id do
        on 'ack' do

          # Ah, HTML consortium, why do you constantly flipflop on DELETE?
          post do
            acknowledger.call(id: inbox[:id]).to_result

            res.redirect '/alerts'
          end
        end
      end

    end
  end
end
