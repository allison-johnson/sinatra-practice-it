class Student < ActiveRecord::Base
    belongs_to :teacher 
    has_many :student_questions
    has_many :questions, through: :student_questions

    validates_presence_of :first_name, :last_name, :grade
    validates :grade, numericality: {only_integer: true, greater_than_or_equal_to: 9, less_than_or_equal_to: 12}
end #class