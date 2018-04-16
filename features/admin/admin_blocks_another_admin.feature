Feature: Admin blocks another Admin
  For any of several reasons (departures, etc), it may become necessary to
  disable the account of a given Admin.

  Background:
    Given I'm an Admin with valid credentials
    And there is 1 other active Admin

  Scenario: Blocking an Admin
    Given I'm on the Admin list
    When I click on the other Admin's status
    Then that Admin is blocked
    And they receive an email indicating that they have been blocked

  Scenario: A signed-in Admin is blocked
    Given I'm on the main dashboard
    When the other Admin blocks me
    Then nothing immediately happens

    When I refresh the page
    Then I am signed out
    And I am advised that I have been blocked

  Scenario: A blocked Admin attempts to sign in
    Given I'm not signed in
    And I've been blocked
    When I attempt to sign in
    And I am advised that I have been blocked