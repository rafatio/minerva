class CreatePaymentType < ActiveRecord::Migration[5.2]
  def change
    create_table :payment_types do |t|
      t.string :name,      null: false
      t.string :code,      null: false
    end

    add_reference :payments, :payment_type, foreign_key: true
  end
end
