Feature: Signing in
  Scenario: Unsuccessful signin
    Given a user visits the signin page
    When he submits invalid signing information
    Then he should see an error message

  Scenario: Successful signin
    Given a user visits the signin page
    And the user has an account
    And the user submits valid signin information
    Then he should see his profile page
    And he should see a signout link

	Scenario: xyz
		Given a user by the name of "mark"
		And the email of "someemail@example.com"
		Then he should see his profile page
