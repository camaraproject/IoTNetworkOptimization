
Feature: IoT Network Optimization API - Power Saving Features

  # ==============================================================
  # Positive Scenario: Enable power-saving successfully
  # ==============================================================

  Scenario: Successfully enable power-saving features for a fleet of IoT devices
    Given an API consumer with valid OAuth2 access token and scope 'iot-management:power-saving:write'
    And a valid list of IoT devices with identifiers (e.g., phone number and IP address)
    And a valid notification sink endpoint with credentials
    When the API consumer sends a POST request to /features/power-saving with enabled flag set to true and a specified time window
    Then the API responds with HTTP status 200
    And the response includes a transactionId
    And the response includes activationStatus entries for each device with status "in-progress"
    When the API completes processing and sends a callback to the notification sink
    Then the callback payload includes activationStatus for each device with status "success"

  # ==============================================================
  # Negative Scenario: Invalid device identifier
  # ==============================================================

  Scenario: Fail to enable power-saving when an invalid device identifier is provided
    Given an API consumer with valid OAuth2 token
    And an invalid list of device identifiers (e.g., malformed phone number)
    When the API consumer sends a POST request to /features/power-saving
    Then the API responds with HTTP status 400
    And the error code is "INVALID_ARGUMENT"

  # ==============================================================
  # Negative Scenario: Unauthorized request
  # ==============================================================

  Scenario: Fail to enable power-saving when no authentication token is provided
    Given an API consumer without an OAuth2 token
    When the API consumer sends a POST request to /features/power-saving
    Then the API responds with HTTP status 401
    And the error code is "UNAUTHENTICATED"

  # ==============================================================
  # Negative Scenario: Forbidden due to insufficient permissions
  # ==============================================================

  Scenario: Fail to enable power-saving when the token does not have write scope
    Given an API consumer with an OAuth2 token missing 'iot-management:power-saving:write' scope
    When the API consumer sends a POST request to /features/power-saving
    Then the API responds with HTTP status 403
    And the error code is "PERMISSION_DENIED"

  # ==============================================================
  # Scenario: Retrieve transaction status
  # ==============================================================

  Scenario: Successfully retrieve the power-saving transaction status
    Given an API consumer with valid OAuth2 token and scope 'iot-management:power-saving:read'
    And a valid transactionId received from a previous POST request
    When the API consumer sends a GET request to /features/power-saving/transactions/{transactionId}
    Then the API responds with HTTP status 200
    And the response includes activationStatus for each device

  # ==============================================================
  # Negative Scenario: Retrieve status with invalid transactionId
  # ==============================================================

  Scenario: Fail to retrieve status for an unknown transactionId
    Given an API consumer with valid OAuth2 token
    And an invalid or non-existent transactionId
    When the API consumer sends a GET request to /features/power-saving/transactions/{transactionId}
    Then the API responds with HTTP status 404
    And the error code is "NOT_FOUND"

  # ==============================================================
  # Scenario: Callback reception
  # ==============================================================

  Scenario: Receive and validate callback on transaction completion
    Given the API consumer's notification sink endpoint is reachable and authorized
    And a power-saving transaction was initiated previously
    When the API sends a callback to the notification sink URL
    Then the callback includes a CloudEvent envelope with specversion "1.0"
    And the event type is "org.camaraproject.iot.dta-status-changed-event"
    And the data field includes activationStatus for all devices
    And the data includes a valid transactionId

