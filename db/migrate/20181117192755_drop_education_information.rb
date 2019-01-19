class DropEducationInformation < ActiveRecord::Migration[5.2]
  def change
    drop_table :education_informations
  end
end
