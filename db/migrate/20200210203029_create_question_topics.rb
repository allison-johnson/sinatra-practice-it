class CreateQuestionTopics < ActiveRecord::Migration[6.0]

  def change
    create_table :question_topics do |t|
      t.integer :question_id
      t.integer :topic_id
    end #do
  end #change

end #class
