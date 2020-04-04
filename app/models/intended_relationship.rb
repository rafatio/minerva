# == Schema Information
#
# Table name: intended_relationships
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  associate  :boolean
#  financial  :boolean
#  mentoring  :boolean
#  tutoring   :boolean
#  remarks    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class IntendedRelationship < ApplicationRecord
  belongs_to :user

  validates :user, presence: true
end
