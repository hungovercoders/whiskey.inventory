Feature: Distillery Interactions
  for help, see: https://github.com/intuit/karate/wiki/IDE-Support

  Background:
    * url 'http://localhost:5240/'

  Scenario: get all users
    Given path 'distilleries'
    When method get
    Then status 200
    And match each response == 
    """
    { 
      name: '#string', 
      website: '#string', 
      region: '#string', 
      country: '#string', 
      location: { 
        lat: '#number', 
        lng: '#number' 
      } 
    }
    """