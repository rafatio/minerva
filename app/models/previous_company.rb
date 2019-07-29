# == Schema Information
#
# Table name: previous_companies
#
#  id                          :integer          not null, primary key
#  professional_information_id :integer          not null
#  name                        :string           not null
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#

class PreviousCompany < ApplicationRecord
    belongs_to :professional_information

    validates :name, presence: true
end
