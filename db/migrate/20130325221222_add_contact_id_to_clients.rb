class AddContactIdToClients < ActiveRecord::Migration
  def change
    add_column :clients, :contact_id, :integer
    add_index :clients, :contact_id
  end
end
