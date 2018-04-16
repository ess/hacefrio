Feature: Admin blesses a blocked Admin
  Mistakes occasionally happen, and perfectly respectable Admins occasionally
  get blocked. So, we should have a way to unblock them when this comes to
  our attention.

  Background:
    Given I'm an Admin with valid credentials
    And there is 1 other blocked Admin

  Scenario: Blessing an Admin
    Given I'm on the Admin list
    When I click on the other Admin's status
    Then that Admin is unblocked
    And they receive an email indicating that they have been unblocked
