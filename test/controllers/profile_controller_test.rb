require 'test_helper'

class ProfileControllerTest < ActionDispatch::IntegrationTest

  setup do
    @user1 = users(:user_1)
    @user2 = users(:user_2)
  end

  test "should be authenticated to show profile" do
    get profile_index_url
    perform_unauthenticated_checks
  end

  test "should show profile user 1" do
    sign_in(@user1)
    get profile_index_url
    assert_response :success
    assert_select 'title', "Informações Cadastrais | Instituto Reditus"

    check_single_value_form_input('person-name', 'person 1')
    check_single_value_form_input('person-cpf', '85331077064')
    #check_single_value_form_input('person-gender', 'Masculino')
    check_single_value_form_input('person-birthdate', '1990-01-01')
    check_single_value_form_input('person-rg', '12345678')

  end

  def check_single_value_form_input(input_name, value)
    assert_select 'form input[name=' + input_name + ']' do
      assert_select "[value=?]", value
    end
  end

end
