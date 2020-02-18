To do
[] Teacher show page URL should be /teachers/:username instead of /teachers/:id

[] Redirect for delete action? (Really, clean up all failures and worst-case redirects)

[x] Password confirmation on sign-up page

[] Radio buttons for difficulty?

[] Move index action to parent controller? What should index page look like? (Maybe a link to log in if user isn't logged in, otherwise link to teacher's show page)

Additional Features
- in student_questions join table, add boolean 'completed' column to keep track of whether the student has completed the question (not just been assigned).
    * On student show page, distinguish between assigned/completed questions
    * On question show page, distinguish between students who have been assigned the question and students who have completed the question

- alphabetize topic list on teacher show page and topic index page

- import CSV files with topics and questions ("Question #1", etc.) and use to seed databases. Allow user to do the same!

- a layout page! make it pretty...

- confirm password 

- auto suggest usernmame (first_initial-last_name-number)

- for students, validate uniqueness of first/last name combination

- ability to change password?

