# == Schema Information
#
# Table name: education_levels
#
#  id   :integer          not null, primary key
#  name :string           not null
#

class EducationLevel < ApplicationRecord
    has_many :education_informations
end
