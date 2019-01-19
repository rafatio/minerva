class AddColumnsToAddress < ActiveRecord::Migration[5.2]
  def change
    add_column :addresses, :street, :string
    add_column :addresses, :neighborhood, :string
  end
end
