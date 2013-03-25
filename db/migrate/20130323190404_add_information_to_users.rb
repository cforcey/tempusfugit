class AddInformationToUsers < ActiveRecord::Migration
  def change
    add_column :users, :first, :string, :null => false
    add_column :users, :middle, :string
    add_column :users, :last, :string, :null => false
    add_column :users, :organization, :string
    add_column :users, :hourly_rate, :integer, :null => false, :default => 0
    add_column :users, :message, :string
    add_column :users, :time_zone, :string
    add_column :users, :roles_mask, :integer, :default => 1

    add_index :users, :roles_mask
    add_index :users, [:last, :first, :middle]
  end
end
