# Specifications for the Sinatra Assessment

[x] Use Sinatra to build the app
- The 'sinatra' gem is required in the Gemfile
- config.ru runs/uses several Sinatra Controllers, all of which inherit from ApplicationController


[x] Use ActiveRecord for storing information in a database
- Model classes all inherit from ActiveRecord::Base
- Database tables (i.e., teachers) are all related to a model class (i.e., Teacher)
- ActiveRecord associations (belongs_to, has_many) are utlized


[x] Include more than one model class (e.g. User, Post, Category)
- Model classes: Teacher, Student, Question, and Topic
- Classes represented by join tables: QuestionTopic and TeacherStudent


[x] Include at least one has_many relationship on your User model (e.g. User has_many Posts)
- A teacher has_many students, has_many questions through students, and has_many topics through questions.
- A teacher also has_many owned_questions, each of which is represent by a question object whose foreign key is aliased as owner_id for the purposes of associating it uniquely with a teacher

- A student has_many student_questions, and thus has_many questions through student_questions

- A question has_many student_questions, and thus has_many students through student_questions
- A question has_many teachers through students
- A question has_many question_topics, and thus has_many topics through question_topics

- A topic has_many question_topics, and thus has_many questions through question_topics


[x] Include at least one belongs_to relationship on another model (e.g. Post belongs_to User)
- A student belongs_to a teacher

- A question belongs_to an owner, which comes from the teacher class and is aliased with a foreign key of owner_id


[x] Include user accounts with unique login attribute (username or email)
- Teachers create accounts with a first_name, last_name, and username
- Presence of all three attributes is validated on creation

- Uniqueness of username is validated on creation. If a new teacher attempts to create an account with an existing username, they'll see the message 'username has already been taken' when they're redirected back to the signup page. 


[x] Ensure that the belongs_to resource has routes for Creating, Reading, Updating and Destroying
- Creating: Teacher controller has create action corresponding to the route POST '/teachers' 
- Reading: Teacher controller has show action corresponding to the route GET '/teachers/:id'
- Updating: Teacher controller has update action corresponding to the route PATCH '/teachers/:id'. Note that the edit action ensures that a teacher can only view the form to edit their own information.
- Destroying: Teacher controller has delete action corresponding to the route DELETE '/teachers/:id', which ensures that a teacher can only delete their own account.


[x] Ensure that users can't modify content created by other users
- A student can only be updated by the teacher to whom that student belongs
- A teacher can only create a new student for themselves
- A teacher can only assign questions to their students
- A teacher can only update a question that they own (although all teachers can view all questions and assign them to students)


[x] Include user input validations
- When a teacher signs up, they must include a first_name, last_name, and a username that is not already in the system.
- When creating a new student, a teacher must include a first_name, last_name, and grade for that student. The first_name/last_name combination must be unique, and the grade must be an integer between 9 and 12 (includive).
- When a question is created, it must include both a difficulty and a prompt.
- When a topic is created, it must include a name.

[x] BONUS - not required - Display validation failures to user with error message (example form URL e.g. /posts/new)
- If a teacher tries to create an account without completing required fields, they are reminded to complete all fields.
- If a teacher tries to create an account with a username that is already in use, they see the validation error message 'username has already been taken'.

- At the current time, I cannot figure out why validation errors are not displaying upon creation a student with invalid/missing arguments.

[ ] Your README.md includes a short description, install instructions, a contributors guide and a link to the license for your code

Confirm
- [ ] You have a large number of small Git commits
- [ ] Your commit messages are meaningful
- [ ] You made the changes in a commit that relate to the commit message
- [ ] You don't include changes in a commit that aren't related to the commit message