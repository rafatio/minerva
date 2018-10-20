class CreateProfessionalInformation < ActiveRecord::Migration[5.2]
  def change
    create_table :professional_informations do |t|
      t.references :user, foreign_key: true
      t.string :company,           null: false
      t.string :position,          null: false
      t.string :previous_companies, null: true
      t.integer :admission_year,   null: true
      t.decimal :salary, precision: 12, scale: 2
      t.decimal :estimated_wealth, precision: 16, scale: 2
      t.timestamps
    end
  end
end
