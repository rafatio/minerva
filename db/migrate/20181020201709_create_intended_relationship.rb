class CreateIntendedRelationship < ActiveRecord::Migration[5.2]
  def change
    create_table :intended_relationships do |t|
      t.references :user, foreign_key: true
      t.boolean :associate,        null: true
      t.boolean :financial,        null: true
      t.boolean :mentoring,        null: true
      t.boolean :tutoring,         null: true
      t.string  :remarks,          null: true
      t.timestamps
    end
  end
end
