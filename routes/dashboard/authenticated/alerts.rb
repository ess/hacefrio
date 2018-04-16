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

    end
  end
end
