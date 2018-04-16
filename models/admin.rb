class Admin < Ohm::Model
  include Shield::Model
  include Ohm::Timestamps

  attribute :email
  attribute :crypted_password
  attribute :blocked

  unique :email
  index :email

  def self.fetch(email)
    find(email: email).first
  end

  def self.with_serial_number(serial_number)
    find(serial_number: serial_number).first
  end

  def status
    blocked ? 'Disabled' : 'Active'
  end
end
