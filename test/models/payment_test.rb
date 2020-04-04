require 'test_helper'

class PaymentTest < ActiveSupport::TestCase
  test 'check number of payments' do
    assert_equal 3, Payment.count
  end

  test 'check user association' do
    p = payments(:payment_1)
    u = User.find_by(email: 'user1@example.com')
    assert_equal users(:user_1).id, p.user_id
    assert_equal u.id, p.user_id
  end
end
