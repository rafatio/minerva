require 'test_helper'

class PostbackControllerTest < ActionDispatch::IntegrationTest
  # called before every single test
  setup do
    @subscription1 = subscriptions(:subscription_1)
    @subscription2 = subscriptions(:subscription_2)
  end

  # called after every single test
  teardown do
    # when controller is using cache it may be a good idea to reset it afterwards
    #Rails.cache.clear
  end

  test 'handle subscription transaction created' do
    initial_count_payments = @subscription1.payments.count
    postback_service = TransactionPostbackService.new
    transaction_params = {status: 'paid', subscription_id: '411963', amount: '9800'}
    result = postback_service.process_transaction_postback(transaction_params)
    assert_equal 'Pagamento inserido', result
    assert_equal initial_count_payments + 1, @subscription1.payments.count
  end

  test 'handle subscription cancelled' do
    subscription_id = '430164'
    subscription = Subscription.find_by_pagarme_identifier(subscription_id)
    assert subscription.active

    postback_service = SubscriptionPostbackService.new

    subscription_status_changed_params = {id: subscription_id, current_status: 'canceled'}
    result = postback_service.process_status_changed_postback(subscription_status_changed_params)

    assert_equal 'Assinatura atualizada com sucesso', result
    subscription = Subscription.find_by_pagarme_identifier(subscription_id)
    assert_not subscription.active
  end

end
