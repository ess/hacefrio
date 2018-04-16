Feature: Device sends an update
  Once per minute, each registered device will send at least one, but up to
  500 records in a payload. Each of these records *must* contain an epoch
  timestamp, a temperature reading, an air humidity reading, a carbon monoxide
  level reading, and the device status.

  Background:
    Given I'm a registered Device

  Scenario: Device sends a single-record update
    Given I have the following updates to send:
      | Timestamp   | Temp  | Humidity  | CO Level  | Status  |
      | 1523555834  | 30.0  | 32.0      | 1.0       | Okay    |

    When I post my JSON payload to the updates endpoint
    Then I'm advised that the update succeeded
    And each of the provided sensors is recorded

  Scenario: Device sends a multi-record update
    Given I have the following updates to send:
      | Timestamp   | Temp  | Humidity  | CO Level  | Status  |
      | 1523555834  | 30.0  | 32.0      | 1.0       | Okay    |
      | 1523555894  | 31.5  | 32.5      | 1.2       | Okay    |
    When I post my JSON payload to the updates endpoint
    Then I'm advised that the update succeeded
    And each of the provided sensors is recorded

  Scenario: Device sends an empty update
    When I post an empty JSON payload to the updates endpoint
    Then I'm advised that the update succeeded
    But no new sensors are recorded
    And an alert is generated regarding the empty update

  Scenario: Device has invalid authentication credentials
    Given I'm an unregistered device
    And I have the following updates to send:
      | Timestamp   | Temp  | Humidity  | CO Level  | Status  |
      | 1523555834  | 30.0  | 32.0      | 1.0       | Okay    |
    When I post my JSON payload to the updates endpoint
    Then I'm advised that I'm not authorized to use the endpoint
    And no new sensors are recorded
    But an alert is generated regarding the failed authentication attempt
