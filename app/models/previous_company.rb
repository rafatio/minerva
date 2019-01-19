class PreviousCompany < ApplicationRecord
    belongs_to :professional_information

    validates :name, presence: true
end
