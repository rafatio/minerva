# frozen_string_literal: true

class CreatePayments < ActiveRecord::Migration[5.2]
  def change
    create_table :payments do |t|
      t.references :user, foreign_key: true
      t.decimal :value, precision: 8, scale: 2
      t.text :pagarme_transaction
      t.timestamps
    end
  end
end
