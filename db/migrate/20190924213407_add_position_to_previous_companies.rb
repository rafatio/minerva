# frozen_string_literal: true

class AddPositionToPreviousCompanies < ActiveRecord::Migration[5.2]
  def change
    add_column :previous_companies, :position, :string
  end
end
