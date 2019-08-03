# == Schema Information
#
# Table name: payment_types
#
#  id   :integer          not null, primary key
#  name :string           not null
#  code :string           not null
#

class PaymentType < ApplicationRecord
    has_many :payments
end
