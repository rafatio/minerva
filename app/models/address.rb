# frozen_string_literal: true

# == Schema Information
#
# Table name: addresses
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  country_id   :integer
#  state_id     :integer
#  state_name   :string
#  zip_code     :string
#  city         :string
#  number       :string
#  complement   :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  street       :string
#  neighborhood :string
#

class Address < ApplicationRecord
  belongs_to :user
  belongs_to :country
  belongs_to :state, optional: true

  validates :user, presence: true
end
