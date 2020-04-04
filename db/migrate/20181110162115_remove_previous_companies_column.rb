# frozen_string_literal: true

class RemovePreviousCompaniesColumn < ActiveRecord::Migration[5.2]
  def change
    remove_column :professional_informations, :previous_companies
  end
end
