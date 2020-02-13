class AddOwnerIdToQuestion < ActiveRecord::Migration
  def change
    add_column :questions, :owner_id, :integer 
  end
end
