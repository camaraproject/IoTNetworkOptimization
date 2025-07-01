Feature: CAMARA IoT Network Optimization API - Operation power-saving
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
    And the response body complies with the OAS schema at "/components/schemas/PowerSavingRequest"
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
    Then the power saving settings will be activated for all the devices specified and according to the parameters specified (e.g., just in the selected time period)
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
