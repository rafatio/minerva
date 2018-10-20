class Address < ApplicationRecord
  belongs_to :user
  belongs_to :country
  belongs_to :state

  validates :user, presence: true
end
