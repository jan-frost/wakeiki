Feature: Main Page

  As a user
  I want to see the main page of the app
  So that I can start using the application

  Scenario: Viewing the main page
    Given I have launched the app
    When the app loads
    Then I should see the main page title "Hello, Elm Android App!"
