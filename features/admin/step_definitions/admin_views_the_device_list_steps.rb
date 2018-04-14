Given "there are 3 registered Devices" do
  3.times do
    Device.create(
      serial_number: SecureRandom.hex(16),
      firmware: %w[0 1 2 3 4 5 6 7 8 9].sample(3).join('.')
    )
  end
end

When "I sign in" do
  step "I'm on the sign in page"
  step "I provide my login credentials"
end

Then "I see a list of devices" do
  expect(page).to have_selector('#devices')
end

Then "each device lists its serial, firmware, and registration date" do
  Device.all.each do |device|
    selector = "#device-#{device.id}"
    expect(page).to have_selector(selector)
    within(selector) do
      expect(page).to have_content(device.serial_number)
      expect(page).to have_content(device.firmware)
      expect(page).to have_content(device.created_at)
    end
  end
end
