# == Schema Information
#
# Table name: people
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  name       :string           not null
#  birth_date :datetime         not null
#  gender     :string           not null
#  cpf        :string           not null
#  rg         :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Person < ApplicationRecord
    belongs_to :user

    validates :user, presence: true
    validates :cpf, length: { is: 11 }
    validates :cpf, numericality: { only_integer: true }
    validates :rg, numericality: { only_integer: true }, allow_nil: true
    validates :gender, inclusion: { in: %w(M F), message: '%{value} is not a valid gender' }
  end
