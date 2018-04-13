class Alert < Ohm::Model
  attribute :severity
  attribute :message
  attribute :acknowledged

  reference :device, :Device
end
