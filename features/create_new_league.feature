Feature: User can start a new league

  As a user of the website
  So that I can start a league and invite my friends to play with me
  I want to create a new league and become the League Commissioner 

Background: Start from the New League link on the home page

  Given I am on the home page
  Then I should see "Add new league"

Scenario: Start a new league (happy path)
  When I follow "Add new league"
  And I am on the "New League" page
  And I fill in "Name" with "Das Survivors"
  And I fill in "Confirmation Code" with "confirmation_code"
  And I press "Create New League"
  Then I should be on the "Leagues" page
  And I should see "Das Survivors"