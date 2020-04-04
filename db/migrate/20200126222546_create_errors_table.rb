# frozen_string_literal: true

class CreateErrorsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :error_logs do |t|
      t.string :category
      t.text :message
      t.timestamps
    end
  end
end
