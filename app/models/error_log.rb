class ErrorLog < ApplicationRecord
  validates :category, presence: true
  validates :message, presence: true
end
