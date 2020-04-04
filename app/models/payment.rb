# frozen_string_literal: true

# == Schema Information
#
# Table name: payments
#
#  id                  :integer          not null, primary key
#  user_id             :integer
#  value               :decimal(8, 2)
#  pagarme_transaction :text
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  subscription_id     :integer
#  payment_type_id     :integer
#

class Payment < ApplicationRecord
  belongs_to :user
  belongs_to :subscription, optional: true
  belongs_to :payment_type, optional: true
  serialize :pagarme_transaction

  attr_accessor :card_number, :card_holder_name, :card_expiration_month, :card_expiration_year, :card_cvv, :card_hash
end
