# frozen_string_literal: true

# == Schema Information
#
# Table name: contact_types
#
#  id   :integer          not null, primary key
#  name :string           not null
#

class ContactType < ApplicationRecord
  has_many :contacts
end
