Feature: Admin receives high CO alerts
  Carbon Monoxide is some seriously dangerous stuff. Any time a device reports
  a CO level of greater than 9 parts-per-million, any Admins that are logged in
  need to be alerted to that problem.

  Background:
    Given there is a Device
    And I'm an Admin with valid credentials

  Scenario: Alert comes in while signed in
    Given I'm using the dashboard
    When the device reports a dangerous carbon monoxide level
    Then I do not immediately see the alert

    When I refresh the page
    Then I see that there are unacknowledged critical alerts

    When I click on the notification
    Then I land on the alerts list
    And I see the dangerous carbon monoxide level alert

  Scenario: Alert comes in while not signed in
    Given I'm not signed in
    And the device reports a dangerous carbon monoxide level
    When I sign in
    Then I land on the main dashboard
    And I see that there are unacknowledged critical alerts

    When I click on the notification
    Then I land on the alerts list
    And I see the dangerous carbon monoxide level alert
