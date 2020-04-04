# == Schema Information
#
# Table name: countries
#
#  id          :integer          not null, primary key
#  name        :string           not null
#  order_index :integer
#

class Country < ApplicationRecord
  default_scope { order('order_index ASC, name ASC') }

  has_many :states
end
