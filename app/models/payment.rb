class Payment < ApplicationRecord
  belongs_to :user
  serialize :pagarme_transaction

  attr_accessor :card_number, :card_holder_name, :card_expiration_month, :card_expiration_year, :card_cvv, :card_hash
end
