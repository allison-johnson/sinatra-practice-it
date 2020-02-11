class Teacher < ActiveRecord::Base
  has_secure_password #Includes presence validator on password, do NOT add another one
  has_many :students
  has_many :questions, through: :students
  has_many :topics, through: :questions

  #validates :username, with: /^[A-Za-z0-9]+$/
  validates_presence_of :first_name, :last_name, :username
  validates_uniqueness_of :username

end #class