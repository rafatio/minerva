class Ambassador < ApplicationRecord
    belongs_to :user
    belongs_to :course

    has_many :users

    validates :user, presence: true
    validates :admission_year, presence: true
    validates :admission_year, numericality: { allow_nil: false, greater_than: 1900 }
  end
