class Topic < ActiveRecord::Base
  has_many :question_topics
  has_many :questions, through: :question_topics
end #class