class EducationInformation < ApplicationRecord
    belongs_to :user
    belongs_to :education_level

    validates :user, presence: true
    validates :conclusion_year, numericality: { allow_nil: true, greater_than: 1900 }
end
