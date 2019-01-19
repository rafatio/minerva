class Contact < ApplicationRecord
    belongs_to :user
    belongs_to :contact_type

    validates :user, presence: true
  end
