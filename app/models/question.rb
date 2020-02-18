class Question < ActiveRecord::Base
    has_many :student_questions
    has_many :students, through: :student_questions

    has_many :teachers, through: :students 
    
    has_many :question_topics
    has_many :topics, through: :question_topics

    belongs_to :owner, class_name: "Teacher", foreign_key: :owner_id
    #Have a method called owner, which will grab the owner_id of that question and look for the Teacher on the teachers table who has that as their primary key

    validates_presence_of :difficulty, :prompt
    validates_uniqueness_of :prompt 
end #class