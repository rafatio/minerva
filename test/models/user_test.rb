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

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "check user payments" do
    user = users(:user_1)
    assert_equal 1, user.payments.count
  end

  test "check user profile" do
    user1 = users(:user_1)
    assert_equal 'person 1', user1.person.name
    assert_equal 'Rua RJ', user1.address.street
    assert_equal 2, user1.contacts.count

    user2 = users(:user_2)
    assert_equal 'person 2', user2.person.name
    assert_equal 'Texas street', user2.address.street
    assert_equal 3, user2.contacts.count
  end
end
