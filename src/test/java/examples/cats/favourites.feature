Feature: sample favourites test script
  Background:
    * url baseURL
    * configure headers = { 'x-api-key': #(apiKey) }
    * def data = read('data.json')

  Scenario Outline: save an image as a favourite
    Given path 'favourites'
    And request { image_id: '<image_id>', sub_id: '<sub_id>' }
    When method post
    Then status 200

    Examples:
      |data|


