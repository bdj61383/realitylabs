Feature: User can start a new league

  As a visitor to the website
  So that I can begin playing the game
  I want to sign up as a new user

Background: Start from the New User link on the home page

  Given I am on the home page
  Then I should see "Add new user"

Scenario: Add a new user (happy path)
  When I follow "Add new user"
  And I am on the "New User" page
  And I fill in "Username" with "Cletus Krankjaw"
  And I fill in "Password" with "password"
  And I press "Create New User"
  Then I should be on the "Users" page
  And I should see "Cletus Krankjaw"