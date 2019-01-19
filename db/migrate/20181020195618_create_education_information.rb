class CreateEducationInformation < ActiveRecord::Migration[5.2]
  def change
    create_table :education_informations do |t|
      t.references :user, foreign_key: true
      t.string :graduation_institution
      t.string :graduation_course
      t.integer :graduation_year, null: true
      t.timestamps
    end
  end
end
