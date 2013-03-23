class AddInformationToUsers < ActiveRecord::Migration
  def change
    add_column :users, :first, :string
    add_column :users, :middle, :string
    add_column :users, :last, :string
    add_column :users, :organization, :string
    add_column :users, :hourly_rate, :integer
    add_column :users, :message, :string
    
    add_index :users, [:last, :first, :middle]
  end
end
