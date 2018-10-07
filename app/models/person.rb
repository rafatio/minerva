class Person < ApplicationRecord
    belongs_to :user

    validates :user, presence: true
    validates :cpf, length: { is: 11 }
    validates :cpf, numericality: { only_integer: true }
    validates :rg, numericality: { only_integer: true }
    validates :gender, inclusion: { in: %w(M F), message: "%{value} is not a valid gender" }
  end