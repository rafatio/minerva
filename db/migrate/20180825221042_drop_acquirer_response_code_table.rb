# frozen_string_literal: true

class DropAcquirerResponseCodeTable < ActiveRecord::Migration[5.2]
  def up
    drop_table :acquirer_response_codes
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
