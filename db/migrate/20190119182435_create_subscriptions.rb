class CreateSubscriptions < ActiveRecord::Migration[5.2]
  def change
    create_table :subscriptions do |t|
      t.references :user, foreign_key: true, null: false
      t.decimal :value, precision: 8, scale: 2
      t.boolean :active, null:false
      t.text :pagarme_subscription
      t.integer :pagarme_identifier, null: true
      t.timestamps
    end

    add_column :payments, :subscription_id, :integer
    add_foreign_key :payments, :subscriptions
  end
end
