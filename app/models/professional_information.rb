# == Schema Information
#
# Table name: professional_informations
#
#  id               :integer          not null, primary key
#  user_id          :integer
#  company          :string           not null
#  position         :string           not null
#  admission_year   :integer
#  salary           :decimal(12, 2)
#  estimated_wealth :decimal(16, 2)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

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
