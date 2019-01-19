class Subscription < ApplicationRecord
    belongs_to :user
    has_many :payments
    serialize :pagarme_subscription

    validates :user, presence: true
end
