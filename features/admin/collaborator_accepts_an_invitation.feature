Feature: Collaborator accepts an invitation
  Somebody has asked me to help them monitor a bunch of remote AC units, and
  I am ready to answer that call.

  Scenario: Accepting an invitation
    Given I'm not an Admin
    When an Admin invites me to become one
    Then I receive an invitation email

    When I follow the RSVP link in the email
    Then I land on the account creation page

    When I submit a confirmed password
    Then I become an Admin
    And I land on the main dashboard