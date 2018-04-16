Given "I am viewing any part of the dashboard" do
  step "I am on the main dashboard"
end

Given "I know the serial number of a registered device" do
  memorize_fact(:serial_number, device.serial_number)
end

def search_for(serial)
  within('#device-search') do
    fill_in('serial_number', with: serial)
    find_button('Search').click
  end
end

When "I provide the serial number in the device search box" do
  search_for(recall_fact(:serial_number))
end

Then "I land on the details page for the device in question" do
  step "I land on the details page for that device"
end

When "I provide an invalid serial number in the device search box" do
  step "I am viewing any part of the dashboard"
  memorize_fact(:pre_search, page.current_path)
  search_for(device.serial_number + "bogus")
end

Then "I land on the view from which I searched" do
  expect(page.current_path).to eql(recall_fact(:pre_search))
end

Then "I'm advised that there is no device with that serial" do
  expect(page).to have_content("Couldn't find that device.")
end
