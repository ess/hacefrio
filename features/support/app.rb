require_relative '../../app'

module AppWrapper
  def app
    App
  end
end

World(AppWrapper)
