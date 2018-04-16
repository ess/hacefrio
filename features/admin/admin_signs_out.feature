Feature: Admin signs out
  You know, it doesn't do anybody any favors if you literally work all the time,
  so we should provide an Admin with the ability to sign out of the dashboard.

  Scenario: Admin signs out
    Given I'm an Admin with valid credentials
    And I'm using the dashboard
    When I click on the signout button
    Then I land on the sign in page
    And I am no longer signed in
