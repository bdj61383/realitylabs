Feature: User can start a new league

  As a visitor to the website
  So that I can begin playing the game
  I want to sign up as a new user

Background: Start from the New User link on the home page

  Given the following leagues exist: 
  | name  | confirmation_code | 
  | neato | pass              | 

  And the following contestants exist:
  | name          | survive | immunity | merger | final_three | winner | round |
  | Leroy Jenkins | 1       | 0        | 0      | 0           | 0      | 0     |
  | Larry Page    | 1       | 0        | 0      | 0           | 0      | 0     |
  | James Turner  | 1       | 0        | 0      | 0           | 0      | 0     |
  | Chris Tucker  | 1       | 0        | 0      | 0           | 0      | 0     |
  | Annie Sams    | 1       | 0        | 0      | 0           | 0      | 0     |
  | Jenny Craig   | 1       | 0        | 0      | 0           | 0      | 0     |

  Given I am on the home page
  Then I should see "Add new user"

Scenario: Add a new user (happy path)
  When I follow "Add new user"
  And I am on the "New User" page
  And I fill in "Username" with "Cletus Krankjaw"
  And I fill in "Password" with "password"
  And I fill in "League Name" with "neato"
  And I fill in "League Confirmation Code" with "pass"
  And I press "Create New User"
  Then I should be on the "Users" page
  And I should see "Cletus Krankjaw"