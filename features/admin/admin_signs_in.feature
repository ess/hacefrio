Feature: Admin signs in
  Assuming that an Admin user exists, that user should be able to log in to use
  the admin interface.

  Background:
    Given I'm an Admin with valid credentials
    And I am not signed in

  Scenario: Getting to the sign in form
    When I visit the web app
    Then I see the sign in page

  Scenario: Admin successfully signs in
    Given I'm on the sign in page
    When I provide my login credentials
    Then I land on the main dashboard
    And I am signed in

  Scenario: Admin provides incorrect credentials
    Given I'm on the sign in page
    When I provide invalid login credentials
    Then I land on the sign in page
    And I'm advised that my sign in attempt was unsuccessful