# frozen_string_literal: true

class CreatePerson < ActiveRecord::Migration[5.2]
  def change
    create_table :people do |t|
      t.references :user, foreign_key: true
      t.string :name,              null: false
      t.datetime :birth_date,      null: false
      t.string :gender,            null: false
      t.string :cpf,               null: false
      t.string :rg
      t.timestamps
    end
  end
end
