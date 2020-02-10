class CreateTeachers < ActiveRecord::Migration[6.0]

  def change
    create_table :teachers do |t|
      t.string :username
      t.boolean :is_admin 
      t.string :password_digest
      t.timestamps
    end #do
  end #change

end #class
