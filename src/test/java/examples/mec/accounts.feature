Feature: sample cats test script

  Background:
    * url baseURL
    * configure headers = { 'Content-Type': 'application/json' }

  @getID
  Scenario: Get the accounts list
    Given path 'devices', 'accounts'
    When method get
    Then status 200
    And match response contains read('accounts.json')

  Scenario Outline: Add an account
    * def body = { description: '<description>', name: '<name>', type: '<type>', vendorName: '<vendorName>' }

    Given path 'devices', 'accounts'
    And request body
    When method post
    Then status 201

    Examples:
      |read('data.csv')|

  Scenario: Delete an account
    * def result = call read('accounts.feature@getID')
    * def deviceList = result.response
    * def deviceID = deviceList[0].id

    Given path 'devices', deviceID
    And param permanent = 'false'
    When method delete
    Then status 200

