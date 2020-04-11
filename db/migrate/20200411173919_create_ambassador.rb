class CreateAmbassador < ActiveRecord::Migration[5.2]
  def change
    create_table :ambassadors do |t|
      t.references :user, foreign_key: true, null: false
      t.references :course, foreign_key: true, null: false
      t.integer :admission_year, null: false
      t.timestamps
    end
  end
end
