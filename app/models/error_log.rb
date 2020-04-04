# frozen_string_literal: true

class ErrorLog < ApplicationRecord
  validates :category, presence: true
  validates :message, presence: true
end
