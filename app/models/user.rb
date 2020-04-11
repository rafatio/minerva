# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  admin                  :boolean
#  agreement              :boolean
#

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :rememberable, and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :trackable, :validatable

  validates :agreement, acceptance: { accept: true }

  has_many :payments
  has_one  :person
  has_many :contacts
  has_one  :address
  has_one  :professional_information
  has_many :education_informations
  has_one  :intended_relationship
  has_many :subscriptions
  belongs_to  :ambassador, optional: true

  attr_accessor :skip_password_validation # virtual attribute to skip password validation while saving

  def custom_name
    return ((first_name.nil? ? "" : first_name) + " " + (last_name.nil? ? "" : last_name)).strip()
  end

  def custom_id
    return "User ##{id}"
  end

  protected

  def password_required?
    return false if skip_password_validation

    super
  end


end
