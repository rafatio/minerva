# == Schema Information
#
# Table name: subscriptions
#
#  id                   :integer          not null, primary key
#  user_id              :integer          not null
#  value                :decimal(8, 2)
#  active               :boolean          not null
#  pagarme_subscription :text
#  pagarme_identifier   :integer
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#

class Subscription < ApplicationRecord
    belongs_to :user
    has_many :payments
    serialize :pagarme_subscription

    validates :user, presence: true
end
