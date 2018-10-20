class EducationInformation < ApplicationRecord
    belongs_to :user

    validates :user, presence: true
    validates :graduation_year, numericality: { allow_nil: true, greater_than: 1900 }
end
