Feature: Admin can add a round

  As the admin of the website
  So that I can keep the game progressing 
  I want to add information about the latest Survivor episode

Background: Start from the Contestant index page

  Given I have reset my database.

  And the following contestants exist:
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
  And I uncheck "contestant_5_survive"
  And I check "contestant_2_immunity"
  And I check "contestant_4_final_three"
  And I press "Add New Round Information"
  Then I should be on the "Contestants" page
  And the field "anniesams_survive" should be "false"
  And the field "larrypage_immunity" should be "true"
  And the field "christucker_final_three" should be "true"
  When I follow "Update Round"
  And I press "Add New Round Information"
  Then I should see "Round 2"

  Scenario: Add a League after the season of Survivor has started


