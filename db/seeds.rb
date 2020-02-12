require_relative '../app/models/teacher.rb'
require_relative '../app/models/student.rb'
require_relative '../app/models/question.rb'
require_relative '../app/models/topic.rb'

andy = Teacher.create(username: "achen", password: "engineering")
kyle = Teacher.create(username: "kcoapman", password: "math")
ted = Teacher.create(username: "tcuevas", password: "math")

nakia = Student.create(first_name: "Nakia", last_name: "Green", grade: 11)
nakia.teacher = andy

joshua = Student.create(first_name: "Joshua", last_name: "Troup", grade: 12)
joshua.teacher = kyle

athena = Student.create(first_name: "Athena", last_name: "Lopez", grade: 10)
athena.teacher = ted  

conditionals = Topic.new(name: "Conditionals")
two_d_arrays = Topic.new(name: "Two-Dimensional Arrays")
math_ops = Topic.new(name: "Mathematical Operators")
classes = Topic.new(name: "Classes and Objects")