class Student < ActiveRecord::Base
    belongs_to :teacher 
    has_many :student_questions
    has_many :questions, through: :student_questions
end #class