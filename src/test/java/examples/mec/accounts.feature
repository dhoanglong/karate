Feature: sample cats test script

  Background:
    * url baseURL
    * configure headers = { 'Content-Type': 'application/json' }

  @getID
  Scenario: Get the accounts list
    Given path 'accounts'
    When method get
    Then status 200
    And match response contains read('accounts.json')

  Scenario Outline: Add an account
    * def body = { description: '<description>', name: '<name>', type: '<type>', vendorName: '<vendorName>' }

    Given path 'accounts'
    And request body
    When method post
    Then status 201

    Examples:
      |read('data.csv')|

  Scenario: Delete an account
    * def result = call read('accounts.feature@getID')
    * def accountList = result.response
    * def accountID = accountList[0].id

    Given path accountID
    When method delete
    Then status 200

