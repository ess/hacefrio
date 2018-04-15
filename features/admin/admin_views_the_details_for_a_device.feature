Feature: Admin views the details for a device
  When viewing a specific device, an Admin sees all of the device-level
  information that they see on the main device list, but they also get
  the last reported value for each of the device's sensors.

  Background:
    Given there is a Device
    And I'm an Admin with valid credentials

  Scenario: Browsing to the details for a device
    Given I am on the main dashboard
    When I browse to the existing device
    Then I land on the details page for that device

  Scenario: Checking out the device information (device has sent updates)
    Given the Device has sent at least one update
    When I browse to the device's details page
    Then I see its serial, firmware, and registration date
    And I see its most recent temperature reading
    And I see its most recent air humidity reading
    And I see its most recent carbon monoxide level reading
    And I see its most recent health status

  Scenario: Checkout out the device information (device has not sent updates)
    Given the Device has not sent any updates
    When I browse to the device's details page
    Then I see its serial, firmware, and registration date
    But I'm advised that there is no sensor data to show
