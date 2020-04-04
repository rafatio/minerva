class CreateAddress < ActiveRecord::Migration[5.2]
  def change
    create_table :countries do |t|
      t.string :name, null: false
    end

    create_table :states do |t|
      t.references :country, foreign_key: true
      t.string :name, null: false
      t.string :code, null: false
    end

    create_table :addresses do |t|
      t.references :user, foreign_key: true
      t.references :country, foreign_key: true
      t.references :state, foreign_key: true
      t.string :state_name
      t.string :zip_code
      t.string :city
      t.string :number
      t.string :complement
      t.timestamps
    end
  end
end
