# frozen_string_literal: true

class AddAgreementToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :agreement, :boolean
  end
end
