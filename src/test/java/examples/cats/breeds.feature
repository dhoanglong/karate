Feature: sample cats test script

  Background:
    * url baseURL
    * configure headers = { 'x-api-key': #(apiKey) }

  Scenario: Get the cat breeds list
    Given path 'breeds'
    When method get
    Then status 200

  @getID
  Scenario: Search for breed by name
    Given path 'breeds', 'search'
    And param q = 'Abyssinian'
    When method get
    Then status 200
    And match response contains read('breed.json')

  Scenario: Search images by breed
    * def breeds = call read('breeds.feature@getID')
    * def id = breeds.response[0].id
    * def name = breeds.response[0].name

    Given path 'images', 'search'
    And param breed_id = id
    When method get
    Then status 200
    And match response[0].breeds[0] contains {name: '#(name)'}
