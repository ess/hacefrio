Feature: Admin invites a Collaborator
  Monitoring is rather painful if you are the only one doing it. That being
  the case, let's give Admins the ability to invite others to help them.

  Background:
    Given I'm an Admin with valid credentials

  Scenario: Admin sends an invitation
    Given I'm on the Admins list
    When I click on the Invite a Collaborator button
    Then I land on the invitation creator

    When I submit the collaborator's email address
    Then I land on the Admin list
    And I'm advised that my invitation has been sent
    And the Collaborator receives an invitation email
