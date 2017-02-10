Feature: Person Detail Access

  @valid
  Scenario: Enters in person detail
    Given User is in home
    When User taps a person
    Then User has arrived to person detail
