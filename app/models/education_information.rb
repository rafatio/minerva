# frozen_string_literal: true

# == Schema Information
#
# Table name: education_informations
#
#  id                 :integer          not null, primary key
#  user_id            :integer          not null
#  education_level_id :integer          not null
#  institution        :string           not null
#  course             :string           not null
#  conclusion_year    :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class EducationInformation < ApplicationRecord
  belongs_to :user
  belongs_to :education_level

  validates :user, presence: true
  validates :conclusion_year, numericality: { allow_nil: true, greater_than: 1900 }
end
