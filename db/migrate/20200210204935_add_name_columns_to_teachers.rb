class AddNameColumnsToTeachers < ActiveRecord::Migration[6.0]
  def change
    add_column :teachers, :last_name, :string
    add_column :teachers, :first_name, :string
  end
end
