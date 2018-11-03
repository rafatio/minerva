class Address < ApplicationRecord
  belongs_to :user
  belongs_to :country
  belongs_to :state, optional: true

  validates :user, presence: true
end
