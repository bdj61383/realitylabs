Feature: Admin can add a round

  As the admin of the website
  So that I can keep the game progressing 
  I want to add information about the latest Survivor episode

Background: Start from the Contestant index page

  Given the following contestants exist:
  | name          | survive | immunity | merger | final_three | winner | round |
  | Leroy Jenkins | 1       | 0        | 0      | 0           | 0      | 0     |
  | Larry Page    | 1       | 0        | 0      | 0           | 0      | 0     |
  | James Turner  | 1       | 0        | 0      | 0           | 0      | 0     |
  | Chris Tucker  | 1       | 0        | 0      | 0           | 0      | 0     |
  | Annie Sams    | 1       | 0        | 0      | 0           | 0      | 0     |
  | Jenny Craig   | 1       | 0        | 0      | 0           | 0      | 0     |

  And I am on the "Contestants" page
  Then I should see "Update Round"

Scenario: Add a new round
  When I follow "Update Round"
  And I uncheck "contestant_1_survive"
  And I press "Add New Round Information"
  Then I should be on the "Contestants" page
  And the field "leroyjenkins_survive" should be "false"
