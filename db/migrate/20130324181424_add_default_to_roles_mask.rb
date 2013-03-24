class AddDefaultToRolesMask < ActiveRecord::Migration
  def up
    change_column :users, :roles_mask, :integer, :default => 1
  end
  def down
    change_column :users, :roles_mask, :integer
  end
end
