class Student < ActiveRecord::Base
    belongs_to :teacher 
    has_many :student_questions
    has_many :questions, through: :student_questions

    validates_presence_of :first_name, :last_name, :grade
    #validates :first_name, uniqueness: {scope: :last_name}
    
    validates :grade, numericality: {only_integer: true, greater_than_or_equal_to: 9, less_than_or_equal_to: 12}

    def self.in_database?(a_student)
      self.where("first_name = ? AND last_name = ? AND grade = ?", a_student.first_name, a_student.last_name, a_student.grade).size != 0
    end #self.in_database?

end #class