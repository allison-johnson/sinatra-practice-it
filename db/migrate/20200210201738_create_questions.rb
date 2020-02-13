class CreateQuestions < ActiveRecord::Migration

  def change
    create_table :questions do |t|
      t.string :difficulty
      t.text :prompt 
    end #do
  end #change

end #class
