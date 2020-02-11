class AddOwnerIdToQuestion < ActiveRecord::Migration[6.0]
  def change
    add_column :questions, :owner_id, :integer 
  end
end
