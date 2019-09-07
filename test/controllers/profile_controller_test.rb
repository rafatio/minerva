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
    check_form_selected_option('person-gender', 'M')
    check_single_value_form_input('person-birthdate', '1990-01-01')
    check_single_value_form_input('person-rg', '12345678')

    check_single_value_form_input('contact-mobile', '(21) 99999-9999')
    check_single_value_form_input('contact-facebook', 'fb1')
    check_single_value_form_input('contact-linkedin', '')
    check_single_value_form_input('contact-skype', 'skype1')
    check_form_selected_option('contact-preferred', 'Facebook')
    # this user does not have any secondary emails

    check_form_selected_option('address-country', 'Brasil')
    check_single_value_form_input('address-cep', '11222333')
    check_single_value_form_input('address-street', 'Rua RJ')
    check_single_value_form_input('address-number', '123')
    check_single_value_form_input('address-complement', 'apt 123')
    check_single_value_form_input('address-neighborhood', 'Bairro X')
    check_single_value_form_input('address-city', 'Rio de Janeiro')
    check_single_value_form_input('address-state', 'RJ')

    check_single_value_form_input('professional-company', 'Empresa 1')
    check_single_value_form_input('professional-position', 'Gerente')
    check_single_value_form_input('professional-admission-year', '2010')
    check_single_value_form_input('professional-previous-company0', 'Empresa antiga 2')
    check_single_value_form_input('professional-previous-company1', 'Empresa antiga 1')

    check_form_selected_option('education-level0', 'Doutorado')
    check_single_value_form_input('education-institution0', 'PUC')
    check_single_value_form_input('education-course0', 'Curso Doutorado 1 1')
    check_single_value_form_input('education-conclusion-year0', '2016')

    check_form_selected_option('education-level1', 'Mestrado')
    check_single_value_form_input('education-institution1', 'UFF')
    check_single_value_form_input('education-course1', 'Curso Mestrado 1 1')
    check_single_value_form_input('education-conclusion-year1', '2012')

    check_form_selected_option('education-level2', 'Graduação')
    check_single_value_form_input('education-institution2', 'UFRJ')
    check_single_value_form_input('education-course2', 'Curso Graduação 1 1')
    check_single_value_form_input('education-conclusion-year2', '2010')

    check_form_checkbox_selected('relationship-associate', true)
    check_form_checkbox_selected('relationship-financial', false)
    check_form_checkbox_selected('relationship-mentoring', true)
    check_form_checkbox_selected('relationship-tutoring', false)
    check_single_value_form_input('relationship-remarks', '')

  end

  test "should show profile user 2" do
    sign_in(@user2)
    get profile_index_url
    assert_response :success
    assert_select 'title', "Informações Cadastrais | Instituto Reditus"

    check_single_value_form_input('person-name', 'person 2')

    check_form_selected_option('contact-preferred', 'E-mail')
    check_single_value_form_input('contact-secondary-mail0', 'email22')
    check_single_value_form_input('contact-secondary-mail1', 'email21')
    check_single_value_form_input('contact-secondary-mail2', 'email23')

    check_form_selected_option('address-country', 'Estados')
    check_single_value_form_input('address-zipcode', '123456789')
    check_single_value_form_input('address-state', 'Texas')

    check_form_checkbox_selected('relationship-associate', false)
    check_form_checkbox_selected('relationship-financial', true)
    check_form_checkbox_selected('relationship-mentoring', false)
    check_form_checkbox_selected('relationship-tutoring', true)
    check_single_value_form_input('relationship-remarks', 'obs 123')

  end

  def check_single_value_form_input(input_name, value)
    assert_select 'form input[name=' + input_name + ']' do
      assert_select "[value=?]", value
    end
  end

  def check_form_selected_option(select_input_name, value)
    assert_select 'form select[name=' + select_input_name + ']' do
      assert_select 'option[selected=selected]' do
        assert_select "[value=?]", value
      end
    end
  end

  def check_form_checkbox_selected(checkbox_input_name, checked)
    assert_select 'form input[name=' + checkbox_input_name + '][type=checkbox]' + (checked ? '[checked]' : ''), 1
    if (!checked)
      #must also assert that it is not checked
      assert_select 'form input[name=' + checkbox_input_name + '][type=checkbox][checked]', 0
    end
  end

end
