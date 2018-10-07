class AddPreferredToContacts < ActiveRecord::Migration[5.2]
  def change
    add_column :contacts, :preferred, :boolean
  end
end
