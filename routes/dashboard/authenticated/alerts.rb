module Dashboard
  module Authenticated
    Alerts = Syro.new(Deck) do
      page[:extended_header] = partial(
        'views/authenticated/devices/search_form.mote',
        return_path: req.path
      )

      get do
        page[:title] = 'Alerts'
        render(
          "views/authenticated/alerts/index.mote",
          alerts: alerts.all.sort(created_at: 'DESC')
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
