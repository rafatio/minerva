# frozen_string_literal: true

class CreateAcquirerResponseCodes < ActiveRecord::Migration[5.2]
  def change
    create_table :acquirer_response_codes do |t|
      t.string :code
      t.string :description
      t.string :message

      t.timestamps
    end
  end
end
