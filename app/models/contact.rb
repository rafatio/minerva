# frozen_string_literal: true

# == Schema Information
#
# Table name: contacts
#
#  id              :integer          not null, primary key
#  user_id         :integer
#  contact_type_id :integer
#  value           :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  preferred       :boolean
#

class Contact < ApplicationRecord
  belongs_to :user
  belongs_to :contact_type

  validates :user, presence: true
  end
