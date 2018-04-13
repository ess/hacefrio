Feature: Device registers itself
  In order to communicate with the authenticated endpoints, a device needs
  to be able to register itself and receive an authentication secret.

  Background:
    Given I'm a Device with the following information:
      | Serial Number | Firmware Version  |
      | d34db33f      | 1.2.3             |

  Scenario: An unknown Device registers
    Given I'm not yet registered on the API
    When I post my information to the registration endpoint
    Then I receive a valid response
    And the JSON body contains an authentication secret and registration date

  Scenario: A registered Device attempts to register
    Given I am already registered on the API
    When I post my information to the registration endpoint
    Then I receive a 422 response
    And the JSON body reflects an error
    And an alert is generated regarding the re-registration attempt
    But no changes are made to my credentials
