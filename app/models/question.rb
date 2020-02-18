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

    def self.my_questions(an_owner_id)
      Question.all.select{|question| question.owner_id == an_owner_id.to_i }
    end #self.my_questions

    def self.other_questions(an_owner_id)
      Question.all.select{|question| question.owner_id != an_owner_id.to_i }
    end #self.other_questions


end #class