#Teachers
allison = Teacher.create(username: "ajohnson", password: "cs", first_name: "Allison", last_name: "Johnson")
syrena = Teacher.create(username: "sburnam", password: "biology", first_name: "Syrena", last_name: "Burnam")
andy = Teacher.create(username: "achen", password: "engineering", first_name: "Andy", last_name: "Chen")
kyle = Teacher.create(username: "kcoapman", password: "math", first_name: "Kyle", last_name: "Coapman")
ted = Teacher.create(username: "tcuevas", password: "math", first_name: "Ted", last_name: "Cuevas")

#Students
hikmah = Student.create(first_name: "Hikmah", last_name: "Okoya", grade: 11)
hikmah.teacher = allison
hikmah.save

muiz = Student.create(first_name: "Muiz", last_name: "Yusuff", grade: 11)
muiz.teacher = allison
muiz.save

oge = Student.create(first_name: "Oge", last_name: "Ibida", grade: 12)
oge.teacher = syrena
oge.save

nakia = Student.create(first_name: "Nakia", last_name: "Green", grade: 11)
nakia.teacher = andy
nakia.save

joshua = Student.create(first_name: "Joshua", last_name: "Troup", grade: 12)
joshua.teacher = kyle
joshua.save

athena = Student.create(first_name: "Athena", last_name: "Lopez", grade: 10)
athena.teacher = ted  
athena.save 

#Topics
math_ops = Topic.create(name: "Mathematical Operators")
strings = Topic.create(name: "Strings")
conditionals = Topic.create(name: "Conditionals")
iteration = Topic.create(name: "Iteration")
classes = Topic.create(name: "Classes and Objects")
arrays = Topic.create(name: "Arrays")
array_lists = Topic.create(name: "Array Lists")
recursion = Topic.create(name: "Recursion")

#Questions & Topic Associations
q1 = Question.create(difficulty: "easy", prompt: "Question about math and strings")
q1.topics << math_ops
q1.topics << strings

q2 = Question.create(difficulty: "medium", prompt: "Question about math and conditionals")
q2.topics << math_ops
q2.topics << conditionals

q3 = Question.create(difficulty: "medium", prompt: "Question about math and iteration")
q3.topics << math_ops
q3.topics << iteration

q4 = Question.create(difficulty: "medium", prompt: "Question about strings and classes")
q4.topics << strings
q4.topics << classes

q5 = Question.create(difficulty: "hard", prompt: "Question about iteration and arrays")
q5.topics << iteration
q5.topics << arrays

q6 = Question.create(difficulty: "medium", prompt: "Question about iteration and array lists")
q6.topics << iteration
q6.topics << array_lists 

q7 = Question.create(difficulty: "hard", prompt: "Question about recursion and math")
q7.topics << math_ops
q7.topics << recursion

q8 = Question.create(difficulty: "hard", prompt: "Question about strings and array lists")
q8.topics << strings
q8.topics << array_lists

#Question-Student Associations
questions = [q1, q2, q3, q4, q5, q6, q7, q8]
students = [hikmah, oge, nakia, joshua, athena, muiz]

questions.each do |question|
    selected_students = students.sample(2)
    question.students << selected_students[0]
    question.students << selected_students[1]
end #do

#Give questions owner-id's
teachers = [allison, syrena, andy, kyle, ted]
questions.each do |question|
  question.owner_id = teachers.sample.id
  question.save 
end #do
