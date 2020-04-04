# frozen_string_literal: true

# == Schema Information
#
# Table name: states
#
#  id         :integer          not null, primary key
#  country_id :integer
#  name       :string           not null
#  code       :string           not null
#

class State < ApplicationRecord
  belongs_to :country
end
