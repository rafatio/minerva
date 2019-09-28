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

    test "should be authenticated to list subscriptions" do
        get subscriptions_url
        perform_unauthenticated_checks
    end

    test "should list subscriptions" do
        sign_in(@user2)
        get subscriptions_url
        assert_response :success
        assert_select 'title', "Assinaturas | Instituto Reditus"
        assert_select "tr", count: @user2.subscriptions.count + 1
    end

    test "should not be able to create subscription when not logged in" do
        get new_subscription_url
        perform_unauthenticated_checks
    end

    test "should create subscription" do
        initial_count_subscriptions = Subscription.count
        initial_count_payments = Payment.count

        sign_in(@user1)
        post subscriptions_url, params: {
            subscription: { value: 100 },
            "card-number": "4611275892282287",
            "cvc": "332",
            "card-holders-name": "teste",
            "expiry-month": "8",
            "expiry-year": "23"
        }
        assert_redirected_to subscriptions_url
        assert_equal 'Assinatura realizada com sucesso', flash[:notice]
        assert_equal initial_count_subscriptions + 1, Subscription.count
        assert_equal initial_count_payments + 1, Payment.count
    end

end
