class Question < ActiveRecord::Base
    has_many :student_questions
    has_many :students, through: :student_questions
    has_many :teachers, through: :students 
    has_many :question_topics
    has_many :topics, through: :question_topics
end #class