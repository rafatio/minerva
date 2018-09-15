class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :rememberable, and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :trackable, :validatable

  has_many :payments

  attr_accessor :skip_password_validation  # virtual attribute to skip password validation while saving

  protected
  
  def password_required?
    return false if skip_password_validation
    super
  end
end