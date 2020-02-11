class Question < ActiveRecord::Base
    has_many :student_questions
    has_many :students, through: :student_questions
    has_many :teachers, through: :students 
    has_many :question_topics
    has_many :topics, through: :question_topics
    belongs_to :owner, class_name: "Teacher", foreign_key: :owner_id

    validates_presence_of :difficulty, :prompt
    validates_uniqueness_of :prompt 
end #class