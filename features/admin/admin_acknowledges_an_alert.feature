Feature: Admin acknowledged an Alert
  Having a ton of alerts sticking around, particularly critical alerts, could
  be a problem. To that end, an Admin should be able to acknowledge an alert,
  which effectively removes it from the system.

  Background:
    Given there's an Alert
    And I'm an Admin with valid credentials

  Scenario: Viewing the alerts page
    Given I'm using the dashboard
    When I browse to the Alerts page
    Then I see all current alerts

  Scenario: Acknowledging an alert
    Given I'm on the Alerts page
    When I click the acknowledge button for an alert
    Then I land on the Alerts page
    And that alert is no longer present
