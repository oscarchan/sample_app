Feature: Editing User Settings
  Scenario: Successful User Model change
    Given a user visits his setting page
    When he submits name change
    Then his name is changed