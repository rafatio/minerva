# frozen_string_literal: true

class CreateEducationInformation2 < ActiveRecord::Migration[5.2]
  def change
    create_table :education_levels do |t|
      t.string :name, null: false
    end

    create_table :education_informations do |t|
      t.references :user, foreign_key: true, null: false
      t.references :education_level, foreign_key: true, null: false
      t.string :institution, null: false
      t.string :course, null: false
      t.integer :conclusion_year, null: true
      t.timestamps
    end
  end
end
