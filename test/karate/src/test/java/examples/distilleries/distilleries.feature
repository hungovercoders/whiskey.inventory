Feature: sample karate test script
  for help, see: https://github.com/intuit/karate/wiki/IDE-Support

  Background:
    * url 'http://localhost:5240/'

  Scenario: get all users
    Given path 'distilleries'
    When method get
    Then status 201