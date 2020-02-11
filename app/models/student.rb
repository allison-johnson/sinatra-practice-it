class Student < ActiveRecord::Base
    belongs_to :teacher 
    has_many :student_questions
    has_many :questions, through: :student_questions

    validates_presence_of :first_name, :last_name, :grade
end #class