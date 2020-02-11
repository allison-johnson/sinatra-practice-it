To do
- Do I have show pages for questions/topics/students, each showing reasonable information about that object???
    * Only able to see it if correct teacher is logged in

- Where to redirect if correct teacher is not logged in???

- Where to redirect once topic/question/student is successfully created? Back to teacher show page OR to the show page for that object...

- Teacher show page with 
    * Teacher's name
    * Links to all students' show pages --> list all questions student has completed
    * Links to all questions' show pages --> list topic(s) and students who have completed questions
    * Button to create a student
    * Button to create a topic
    * Button to create a question
    * Button to log out
- Update action: teacher
- Update action: student
- Update action: question

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
- import CSV files with topics and questions ("Question #1", etc.) and use to seed databases
- on question creation, allow teacher to create a new topic as well
- a layout page! make it pretty...
- when teacher logs in they can select whether to view all students or view all questions
- when creating new teacher, if validation error --> recognize which field didn't validate correctly (and auto-populate others, perhaps?)
- confirm password 
- auto suggest usernmame (first_initial-dot-last_name-number)
- for students, validate uniqueness of first/last name combination
- teachers should really be able to share questions ... maybe questions get stored in some sort of global question bank?

Complete
- add checkboxes to Create Question form so teachers can select from existing topics
- create new topic