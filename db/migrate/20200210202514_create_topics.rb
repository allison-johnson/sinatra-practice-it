class CreateTopics < ActiveRecord::Migration

  def change
    create_table :topics do |t|
      t.string :name
    end #do
  end #change

end #class 
