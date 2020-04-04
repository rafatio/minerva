# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  include Devise::Test::IntegrationHelpers

  def perform_unauthenticated_checks
    assert_redirected_to :new_user_session
    follow_redirect!
    assert_response :success
    assert_select 'title', 'Instituto Reditus'
    assert_select 'p', 'Bem-vindo de volta! Use suas credenciais para acessar sua conta'
    assert_equal 'Você precisa se logar ou registrar antes de prosseguir.', flash[:alert]
  end
end
