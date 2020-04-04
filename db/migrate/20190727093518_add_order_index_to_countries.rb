# frozen_string_literal: true

class AddOrderIndexToCountries < ActiveRecord::Migration[5.2]
  def change
    add_column :countries, :order_index, :integer
  end
end
