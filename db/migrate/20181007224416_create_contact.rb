class CreateContact < ActiveRecord::Migration[5.2]
  def change
    create_table :contacts do |t|
      t.references :user, foreign_key: true
      t.references :contact_type, foreign_key: true
      t.string :value,             null: false
      t.timestamps
    end
  end
end
