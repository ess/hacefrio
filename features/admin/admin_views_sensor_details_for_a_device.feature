@timey-wimey
Feature: Admin views sensor details for a device
  In addition to the most recent reading for each sensor, it's desirable to
  be able to dig into each individual sensor's historical data. The filtering
  options for this view are readings from the last day, the last week, the
  last month, and the last year (based on a span of time from the current time).

  Background:
    Given there is a Device
    And that Device has updated once per day for the last year
    And I'm an Admin with valid credentials

  Scenario Outline: Browsing to a specific sensor
    Given I'm viewing the details page for the device
    When I click on the current <Sensor> reading
    Then I land on the details page for the device's <Sensor> sensor
    And I'm advised that I'm seeing the readings for the last day
    And I see an option to view the last week's readings
    And I see an option to view the last month's readings
    And I see an option to view the last year's readings

    Examples:
      | Sensor                |
      | temperature           |
      | air humidity          |
      | carbon monoxide level |
      | health status         |

  Scenario Outline: Viewing readings for the last day
    Given I'm viewing the last day's details for the device's <Sensor> sensor
    Then I see only the <Sensor> readings within the last 24 hours

    Examples:
      | Sensor                |
      | temperature           |
      | air humidity          |
      | carbon monoxide level |
      | health status         |

  Scenario Outline: Viewing readings for the last week
    Given I'm viewing the last week's details for the device's <Sensor> sensor
    Then I see only the <Sensor> readings within the last 7 days

    Examples:
      | Sensor                |
      | temperature           |
      | air humidity          |
      | carbon monoxide level |
      | health status         |

  Scenario Outline: Viewing readings for the last month
    Given I'm viewing the last month's details for the device's <Sensor> sensor
    Then I see only the <Sensor> readings within the last 30 days

    Examples:
      | Sensor                |
      | temperature           |
      | air humidity          |
      | carbon monoxide level |
      | health status         |

  Scenario Outline: Viewing readings for the last year
    Given I'm viewing the last year's details for the device's <Sensor> sensor
    Then I see only the <Sensor> readings within the last 365 days

    Examples:
      | Sensor                |
      | temperature           |
      | air humidity          |
      | carbon monoxide level |
      | health status         |
