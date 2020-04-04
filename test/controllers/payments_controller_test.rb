require 'test_helper'

class PaymentsControllerTest < ActionDispatch::IntegrationTest
  # called before every single test
  setup do
    @user1 = users(:user_1)
  end

  # called after every single test
  teardown do
    # when controller is using cache it may be a good idea to reset it afterwards
    # Rails.cache.clear
  end

  test 'should be authenticated to list payments' do
    get payments_url
    perform_unauthenticated_checks
  end

  test 'should list payments' do
    sign_in(@user1)
    get payments_url
    assert_response :success
    assert_select 'title', 'Assinaturas e Contribuições | Instituto Reditus'
    assert_select 'h1', 'Minhas contribuições'
    assert_select 'tr', count: @user1.payments.count + @user1.subscriptions.count + 2
  end

  test 'should be able to create payment when not logged in' do
    get new_payment_url
    assert_response :success
  end

  test 'should create payment' do
    initial_count = Payment.count

    sign_in(@user1)
    post payments_url, params: {
      payment: { value: 100 },
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
    assert_equal 'Pagamento realizado com sucesso', flash[:notice]
    assert_equal initial_count + 1, Payment.count
  end
end
