class CreateStudents < ActiveRecord::Migration[6.0]

  def change
    create_table :students do |t|
      t.string :last_name
      t.string :first_name
      t.integer :grade
      t.integer :teacher_id
    end #do
  end #change

end #class
