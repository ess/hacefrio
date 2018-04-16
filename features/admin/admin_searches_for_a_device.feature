Feature: Admin searches for a device
  Browsing through a full list of devices could be painful. That being the
  case, an Admin should be able to search for a device given its exact
  serial number.

  Background:
    Given there is a Device
    And I'm an Admin with valid credentials

  Scenario: Searching for a device
    Given I am viewing any part of the dashboard
    And I know the serial number of a registered device
    When I provide the serial number in the device search box
    Then I land on the details page for the device in question

  Scenario: Searching for a non-existent device
    When I provide an invalid serial number in the device search box
    Then I land on the view from which I searched
    And I'm advised that there is no device with that serial