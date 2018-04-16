module Mailer
  MissingSubject = Class.new(ArgumentError)
  MissingText    = Class.new(ArgumentError)

  def self.deliver(message)
    raise MissingSubject if message[:subject].nil?
    raise MissingText    if message[:text].nil?

    defaults = {
      to: "info@example.com",
      from: $env['DEFAULT_FROM']
    }

    mcfeely.deliver(defaults.merge(message))
  end

  def self.mcfeely
    @mcfeely ||= Malone.connect(
      url: $env['MALONE_URL'],
      domain: $env['MALONE_DOMAIN']
    )
  end
end
