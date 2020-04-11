class AddReferrerAmbassadorToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :ambassador_id, :integer
    add_foreign_key :users, :ambassadors
  end
end
