module Dashboard
  class Deck < Syro::Deck
    include Shield::Helpers
    include Mote::Helpers
    include Hacefrio::Requirements::Import[
      'storage.devices',
    ]

    def finish!
      handle 404 do
        page[:title] = 'Are you lost?'
        render('views/404.mote')
      end

      super
    end

    def session
      req.session
    end

    def view
      @view ||= Tas.new do |params|
        mote(params[:src], params)
      end
    end

    def page
      @page ||= view.new.tap do |page|
        page[:src] = 'views/layout.mote'
        page[:content] = view.new
        page[:content][:app] = self
      end
    end

    def render(path, params = {})
      page[:title] ||= 'Dashboard'
      page[:content][:src] = path
      page[:content].update(params)

      res.html(page)
    end

  end
end
