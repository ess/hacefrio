Feature: Admin requests a forgotten password reset
  Forgetting passwords is painful, and even more so if there's no secure way
  to recover one's account.

  Background:
    Given I'm an Admin with invalid credentials
    And I'm not signed in

  Scenario: Requesting a password reset
    Given I'm on the sign in page

    When I click the forgotten password link
    And I provide my email address
    Then I'm advised to check my email
    And I receive a password reset email

  Scenario: Resetting a password
    Given I've received a password reset email
    When I follow the password reset link in the email
    Then I land on the password reset page

    When I provide a confirmed password
    Then I land on the main dashboard
    And I am signed in