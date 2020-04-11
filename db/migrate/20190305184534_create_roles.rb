class CreateRoles < ActiveRecord::Migration[5.2]
  def change
    create_table :roles do |t|
      t.string :name, index: true
      t.timestamps
    end

    create_join_table(:users, :roles) do |t|
      t.timestamps
    end
    add_foreign_key :roles_users, :roles, column: :role_id
    add_foreign_key :roles_users, :users, column: :user_id
    add_index :roles_users, :role_id
    add_index :roles_users, :user_id
    add_index :roles_users, [:role_id, :user_id], :unique => true

  end
end
