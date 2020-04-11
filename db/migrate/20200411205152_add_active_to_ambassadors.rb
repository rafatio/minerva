class AddActiveToAmbassadors < ActiveRecord::Migration[5.2]
  def change
    add_column :ambassadors, :is_active, :boolean
    change_column_default :ambassadors, :is_active, true
  end
end
