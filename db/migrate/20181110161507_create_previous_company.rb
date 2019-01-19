class CreatePreviousCompany < ActiveRecord::Migration[5.2]
  def change
    create_table :previous_companies do |t|
      t.references :professional_information, foreign_key: true, null:false
      t.string :name, null: false
      t.timestamps
    end
  end
end
