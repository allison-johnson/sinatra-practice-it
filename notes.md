To do
- Add 'edit teacher info' link to teacher show page

- Teacher show page URL should be /teachers/:username instead of /teachers/:id

- Delete action for topics?
    * If a question was only associated with Topic X and then Topic X gets deleted, what should happen to the question?

- Do validations get checked when you update an object?

- Update action: teacher

- Redirect for delete action? (Really, clean up all failures and worst-case redirects)

- Teacher should be able to click on a question to see its show page, and then click on a button that says: assign to student. They should see a list of all students who have not been assigned that question, and then be able to check all the students they want to assign it to.

- Radio buttons for difficulty?

- Where to redirect to if a teacher tries to edit a question they don't own? (Generic failure page?)

- Move index action to parent controller? What should index page look like? (Maybe a link to log in if user isn't logged in, otherwise link to teacher's show page)

- Where to redirect once topic/question/student is successfully created? Back to teacher show page OR to the show page for that object...

- Add "Back to Teacher Homepage" button to all pages

Teacher can:
- log in
- log out
- create a new student (if logged in)
    - student associated with teacher
- create a new question (if logged in)
    - associate it with a new topic or an existing topic 
- create a new topic
- edit their own information 
- edit a student, a question, or a topic (from that student, question, or topic's show page)
- right now, all teachers can access all questions ... is that what I want?

Additional Features
- on student creation/update validate that grade is a number 9-12
- import CSV files with topics and questions ("Question #1", etc.) and use to seed databases
- on question creation, allow teacher to create a new topic as well
- a layout page! make it pretty...
- when teacher logs in they can select whether to view all students or view all questions
- when creating new teacher, if validation error --> recognize which field didn't validate correctly (and auto-populate others, perhaps?)
- confirm password 
- auto suggest usernmame (first_initial-dot-last_name-number)
- for students, validate uniqueness of first/last name combination

Complete
- add checkboxes to Create Question form so teachers can select from existing topics
- create new topic
- show page for individual topic (by id)
- show page for individual question (by id)
- show page for individual student (by id)

- index page for questions links to individual show page for each question
- index page for topics links to individual show page for each topic 
- index page for students links to individual show page for each student

- questions index page only shows if correct teacher is logged in (username in URL matches current user's username)
- students index page only shows if correct teacher is logged in (username in URL matches current user's username)
- topics index page only shows if correct teacher is logged in (username in URL matches current user's username)

- teacher can only view student show page if student belongs to them

- Teacher show page with 
    * Teacher's name
    * Links to all students' show pages --> list all questions student has completed
    * Links to all questions' show pages --> list topic(s) and students who have completed questions
    * Links t all topics show pages
    * Button to create a student
    * Button to create a topic
    * Button to create a question
    * Button to log out
    * Shows all questions
    * Shows owned questions ('your questions')

- Add "not found" functionality to show pages for individual questions/students/topics with nonexistent id's

- Edit page for question's prompt and topics

- Able to delete student by clicking button on their show page
- Able to edit student by clicking link on their show page
- Able to delete question by clicking button on its show page
- Able to edit question by clicking link on show page

- If question has no topics yet, indicate that on question show page