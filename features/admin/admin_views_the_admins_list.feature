Feature: Admin views the admins list
  The building block of Admin managment is, effectively, being able to see
  what Admins already exist.

  Background:
    Given I'm an Admin with valid credentials
    Given there are 4 other active Admins
    And there are 5 other blocked Admins

  Scenario: Browsing to the Admins list
    Given I'm using the dashboard
    When I browse to the Admins page
    Then I land on the Admins list

  Scenario: Information shown on the list
    Given I'm on the Admins list
    Then I see a list of all admins
    And I see the email address for each of those admins
    And I see each of the admins' status
