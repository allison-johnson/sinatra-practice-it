class CreateTopics < ActiveRecord::Migration[6.0]

  def change
    create_table :topics do |t|
      t.string :name
    end #do
  end #change

end #class 
