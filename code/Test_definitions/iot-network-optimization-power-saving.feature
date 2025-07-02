Feature: CAMARA IoT Network Optimization API - vwip - Operation power-saving
# Input to be provided by the implementation to the tester
#
# Implementation indications:
#
# Testing assets:
# * One or more IoT devices whose power saving features could be set.
#
  Background: Common power-saving feature setup
    Given the path "/features/power-saving"
    And the header "Content-Type" is set to "application/json"
    And the header "Authorization" is set to a valid access token
    And the header "x-correlator" complies with the schema at "#/components/schemas/XCorrelator"
    And the request body is set by default to a request body compliant with the schema

  # Happy path scenarios

  # This first scenario serves as a minimum
  @power_saving_feature_01_generic_success_scenario_one_device
  Scenario: Common validations for any success scenario, just one device identifier is provided
    # Valid testing default request body compliant with the schema
    Given the request body property "$.devices" carries one valid device which is compliant with the OAS schema at "/components/schemas/Device"
    And "$.enabled" is set to true
    And "$.notificationSink" is set to a proper value
    When the HTTP "POST" request is sent
    Then the power saving settings will be activated for all the devices specified
    And the response status code is 200 
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    # The response has to comply with the generic response schema which is part of the spec
    And the response body complies with the OAS schema at "/components/schemas/PowerSavingResponse"
    And "$.transactionId" is set to a proper value
    # The received callback must be compliant and should carry the aspected values
    And within a limited period of time I should receive a callback at "/components/schemas/NotificationSink/sink"
    And the callback body is compliant with the OAS schema at "/components/callbacks/onTransactionCompleted" with "x-correlator" having the same value as the request header "x-correlator"
    And the callback carries the information defined in "/components/schemas/CloudEventPowerSaving"
    And "/components/schemas/CloudEventPowerSaving" in the callback should contain the parameter "$.transactionId" with the same value as in the 200 response of "/features/power-saving"
    And "/components/schemas/CloudEventPowerSaving" in the callback should contain the parameter "$.activationStatus" set to the expected value
    And each ("$.activationStatus[*].device") that used multiple identifiers in the request body, must return only the identifier used by the network

  # This scenario uses only mandatory parameters specifying a list of devices
  @power_saving_feature_02_more_devices
  Scenario: multiple devices identifiers are provided with just mandatory parameters
    Given the request body property "$.devices" carries an array of valid devices which are compliant with the OAS schema at "/components/schemas/Device"
    And "$.enabled" is set to true
    And "$.notificationSink" is set to a proper value
    When the HTTP "POST" request is sent
    Then the power saving settings will be activated for all the devices specified
    And the response status code is 200 
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    # The response has to comply with the generic response schema which is part of the spec
    And the response body complies with the OAS schema at "/components/schemas/PowerSavingResponse"
    And "$.transactionId" is set to a proper value
    # The received callback must be compliant and should carry the aspected values
    And within a limited period of time I should receive a callback at "/components/schemas/NotificationSink/sink"
    And the callback body is compliant with the OAS schema at "/components/callbacks/onTransactionCompleted" with "x-correlator" having the same value as the request header "x-correlator"
    And the callback carries the information defined in "/components/schemas/CloudEventPowerSaving"
    And "/components/schemas/CloudEventPowerSaving" in the callback should contain the parameter "$.transactionId" with the same value as in the 200 response of "/features/power-saving"
    And "/components/schemas/CloudEventPowerSaving" in the callback should contain the parameter"$.activationStatus"
    And the parameter"$.activationStatus" should be set to the expected value as a list of status, one for each device
    And each ("$.activationStatus[*].device") that used multiple identifiers in the request body, must return only the identifier used by the network

  # This scenario uses also optional parameters with a list of devices
  @power_saving_feature_03_optional_parameters
  Scenario: multiple devices identifiers are provided with also optional parameters
    Given the request body property "$.devices" carries an array of valid devices which are compliant with the OAS schema at "/components/schemas/Device"
    And "$.enabled" is set to true
    And "$.notificationSink" is set to a proper value
    And "$.timePeriod" is set to a proper value
    When the HTTP "POST" request is sent
    Then the power saving settings will be activated for all the devices specified
    And the activation will follow the parameters specified (e.g., only during the selected time period)
    And the response status code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    # The response has to comply with the generic response schema which is part of the spec
    And the response body complies with the OAS schema at "/components/schemas/PowerSavingResponse"
    And "$.transactionId" is set to a proper value
    # The received callback must be compliant and should carry the aspected values
    And within a limited period of time I should receive a callback at "/components/schemas/NotificationSink/sink"
    And the callback body is compliant with the OAS schema at "/components/callbacks/onTransactionCompleted" with "x-correlator" having the same value as the request header "x-correlator"
    And the callback carries the information defined in "/components/schemas/CloudEventPowerSaving"
    And "/components/schemas/CloudEventPowerSaving" in the callback should contain the parameter "$.transactionId" with the same value as in the 200 response of "/features/power-saving"
    And "/components/schemas/CloudEventPowerSaving" in the callback should contain the parameter"$.activationStatus"
    And the parameter"$.activationStatus" should be set to the expected value as a list of status, one for each device
    And each ("$.activationStatus[*].device") that used multiple identifiers in the request body, must return only the identifier used by the network

  # This scenario shows how GET API works
  @power_saving_feature_04_get
  Scenario: Read transaction status
    Given the request path property with the parameter "$.transactionId" set as per the response of the previous POST
    When the HTTP "GET" request is sent
    Then the response status code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    # The response has to comply with the generic response schema which is part of the spec
    And the response body complies with the OAS schema at "/components/schemas/PowerSavingResponse" reporting the current status of the power saving activation for each device

  # This scenario shows how request with invalid device identifier will be handled
  @power_saving_feature_05_invalid_device
  Scenario: Fail to enable power-saving when an invalid device identifier is provided
    Given the request body property "$.devices" carries an invalid device that is not compliant with the OAS schema at "/components/schemas/Device"
    And "$.enabled" is set to true
    And "$.notificationSink" is set to a proper value
    When the HTTP "POST" request is sent
    Then the power saving settings will not be activated for any of the devices specified
    And the response HTTP status code is 400
    And the error code is "INVALID_ARGUMENT"
    And the response header "Content-Type" is "application/json"

    
# This scenario show how request with no authentication token will be handled
  @power_saving_feature_06_no_auth
  Scenario: Fail to enable power-saving when no authentication token is provided
    Given an API consumer without an OAuth2 token
    When the HTTP "POST" request is sent
    Then the API responds with HTTP status 401
    And the error code is "UNAUTHENTICATED"
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "/components/schemas/ErrorInfo"

# This scenario show how request with an OAuth2 token missing 'iot-management:power-saving:write' scope is handled
  @power_saving_feature_07_forbidden_scope
  Scenario: Fail to enable power-saving when the token does not have write scope
    Given an API consumer with an OAuth2 token missing 'iot-management:power-saving:write' scope
    When the HTTP "POST" request is sent
    Then the API responds with HTTP status 403
    And the error code is "PERMISSION_DENIED"
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "/components/schemas/ErrorInfo"

# Negative Scenario: Retrieve status with invalid transactionId
  @power_saving_feature_08_get_status_invalid
  Scenario: Fail to retrieve status for an unknown transactionId
    Given an API consumer with valid OAuth2 token
    And an invalid or non-existent transactionId
    When the API consumer sends a GET request to /features/power-saving/transactions/{transactionId}
    Then the API responds with HTTP status 404
    And the error code is "NOT_FOUND"
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "/components/schemas/ErrorInfo"

  # Scenario: Callback reception
  @power_saving_feature_09_callback_received
  Scenario: Receive and validate callback on transaction completion
    Given the API consumer's notification sink endpoint is reachable and authorized
    And a power-saving transaction was initiated previously
    When the API sends a callback to the notification sink URL
    Then the callback complies CloudEvent envelope with specversion "1.0" at "/components/schemas/CloudEventPowerSaving"
    And the event type is "org.camaraproject.iot.dta-status-changed-event"
    And the data field includes activationStatus for all devices
    And the data includes a valid transactionId
