class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :name, :null => false
      t.string :description
      t.integer :user_id
      t.integer :hourly_rate, :null => false, :default => 0
      t.text :notes

      t.timestamps
    end
    add_index :clients, :name
    add_index :clients, :user_id
  end
end
