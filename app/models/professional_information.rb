class ProfessionalInformation < ApplicationRecord
    belongs_to :user
    has_many :previous_companies, dependent: :destroy

    validates :user, presence: true
    validates :company, presence: true
    validates :position, presence: true
    validates :admission_year, numericality: { allow_nil: true, greater_than: 1900 }
    validates :salary, numericality: { allow_nil: true, greater_than: 0 }
    validates :estimated_wealth, numericality: { allow_nil: true, greater_than: 0 }
end
