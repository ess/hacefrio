module Dashboard
  class Deck < Syro::Deck
    include Shield::Helpers
    include Mote::Helpers
    include Hacefrio::Requirements::Import[
      'storage.devices',
      'storage.admins',
      'storage.alerts',
    ]

    def device_finder
      @device_finder ||= Hacefrio::Workflows::DeviceLookup.new
    end

    def sensor_finder
      @sensor_finder ||= Hacefrio::Workflows::SensorLookup.new
    end

    def acknowledger
      @acknowledger ||= Hacefrio::Workflows::AlertAcknowledge.new
    end

    def reset_request
      @reset_request ||= Hacefrio::Workflows::ResetRequest.new
    end

    def resetter
      @resetter ||= Hacefrio::Workflows::Resetter.new
    end

    def blocker
      @blocker ||= Hacefrio::Workflows::AccountToggle.new
    end

    def finish!
      handle 404 do
        page[:title] = 'Are you lost?'
        render('views/404.mote')
      end

      handle 403 do
        logout(Admin)
        page[:title] = 'Your account is suspended'
        render('views/403.mote')
      end

      super
    end
    
    def unacked_crits?
      alerts.find(severity: 'CRIT').count > 0
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
        page[:extended_header] = authenticated(Admin) ?
          partial(
            'views/authenticated/devices/search_form.mote',
            return_path: req.path
          ) : ''


        page[:nav] = partial(
          authenticated(Admin) ? 'views/authenticated/nav.mote' : 'views/public/nav.mote'
        )

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

    def partial(path, params = {})
      mote(path, params.merge(app: self))
    end

  end
end
