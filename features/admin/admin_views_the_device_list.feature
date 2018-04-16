Feature: Admin views the device list
  After logging in, an Admin is dropped to the main dashboard by default,
  and this seems like a pretty good place to provide the device list.

  Background:
    Given I'm an Admin with valid credentials
    And there are 3 registered Devices

  Scenario: The device list is the main view
    When I sign in
    Then I land on the main dashboard
    And I see a list of devices
    And each device lists its serial, firmware, and registration date