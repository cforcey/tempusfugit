class CreateSpans < ActiveRecord::Migration
  def change
    create_table :spans do |t|
      t.string :name, :null => false
      t.string :description
      t.integer :user_id, :null => false
      t.integer :project_id, :null => false
      t.datetime :start_at, :null => false
      t.datetime :end_at, :null => false
      t.integer :hourly_rate, :null => false, :default => 0
      t.boolean :billable, :null => false, :default => true
      t.datetime :invoiced_at
      t.text :notes

      t.timestamps
    end
    add_index :spans, :name
    add_index :spans, :user_id
    add_index :spans, :project_id
    add_index :spans, :start_at
    add_index :spans, :end_at
    add_index :spans, :billable
    add_index :spans, :invoiced_at
  end
end
