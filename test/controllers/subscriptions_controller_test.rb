require 'test_helper'

class SubscriptionsControllerTest < ActionDispatch::IntegrationTest
  # called before every single test
  setup do
    @user1 = users(:user_1)
    @user2 = users(:user_2)
  end

  # called after every single test
  teardown do
    # when controller is using cache it may be a good idea to reset it afterwards
    #Rails.cache.clear
  end

  test 'should be authenticated to list subscriptions' do
    get payments_url
    perform_unauthenticated_checks
  end

  test 'should list subscriptions' do
    sign_in(@user2)
    get payments_url
    assert_response :success
    assert_select 'title', 'Assinaturas e Contribuições | Instituto Reditus'
    assert_select 'h1', 'Minhas assinaturas'
    assert_select 'tr', count: @user2.subscriptions.count + @user2.payments.count + 2
  end

  test 'should create subscription' do
    initial_count_subscriptions = Subscription.count
    initial_count_payments = Payment.count

    sign_in(@user1)
    post subscriptions_url, params: {
        subscription: { value: 100 },
        "card-number": '4611275892282287',
        "cvc": '332',
        "card-holders-name": 'teste',
        "expiry-month": '8',
        "expiry-year": '23',
        "person-name": @user1.person.name,
        "person-cpf": @user1.person.cpf,
        "person-phone": '+55 21 99999-9999',
        "address-country": 'Brasil',
        "address-cep": '23030006',
        "address-street": 'Travessa C',
        "address-number": '123',
        "address-complement": 'cs 1',
        "address-neighborhood": 'Guaratiba',
        "address-city": 'Rio de Janeiro',
        "address-state": 'RJ'
    }
    assert_redirected_to payments_url
    assert_equal 'Assinatura realizada com sucesso', flash[:notice]
    assert_equal initial_count_subscriptions + 1, Subscription.count
    assert_equal initial_count_payments + 1, Payment.count
  end

end
