class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name, :null => false
      t.string :description
      t.integer :user_id, :null => false
      t.integer :client_id
      t.integer :hourly_rate, :null => false, :default => 0
      t.text :notes

      t.timestamps
    end
    add_index :projects, :name
    add_index :projects, :user_id
    add_index :projects, :client_id
  end
end
