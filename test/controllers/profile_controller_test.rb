# frozen_string_literal: true

require 'test_helper'

class ProfileControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user1 = users(:user_1)
    @user2 = users(:user_2)
    @user3 = users(:user_3)
  end

  test 'should be authenticated to show profile' do
    get profile_index_url
    perform_unauthenticated_checks
  end

  test 'should show profile user 1' do
    sign_in(@user1)
    get profile_index_url
    assert_response :success
    assert_select 'title', 'Informações Cadastrais | Instituto Reditus'

    check_single_value_form_input('person-name', 'person 1')
    check_single_value_form_input('person-cpf', '85331077064')
    check_form_selected_option('person-gender', 'M')
    check_single_value_form_input('person-birthdate', '1990-01-01')
    check_single_value_form_input('person-rg', '12345678')

    check_single_value_form_input('contact-mobile', '+55 (21) 99999-9999')
    check_single_value_form_input('contact-facebook', 'fb1')
    check_single_value_form_input('contact-linkedin', '')
    check_single_value_form_input('contact-skype', 'skype1')
    check_form_selected_option('contact-preferred', 'Facebook')
    # this user does not have any secondary emails

    check_form_selected_option('address-country', 'Brasil')
    check_single_value_form_input('address-cep', '23030006')
    check_single_value_form_input('address-street', 'Travessa C')
    check_single_value_form_input('address-number', '123')
    check_single_value_form_input('address-complement', 'apt 123')
    check_single_value_form_input('address-neighborhood', 'Guaratiba')
    check_single_value_form_input('address-city', 'Rio de Janeiro')
    check_single_value_form_input('address-state', 'RJ')

    check_single_value_form_input('professional-company', 'Empresa 1')
    check_single_value_form_input('professional-position', 'Gerente')
    check_single_value_form_input('professional-admission-year', '2010')
    check_single_value_form_input('professional-previous-company-name0', 'Empresa antiga 2')
    check_single_value_form_input('professional-previous-company-name1', 'Empresa antiga 1')

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

  test 'should show profile user 2' do
    sign_in(@user2)
    get profile_index_url
    assert_response :success
    assert_select 'title', 'Informações Cadastrais | Instituto Reditus'

    check_single_value_form_input('person-name', 'person 2')

    check_form_selected_option('contact-preferred', 'E-mail')
    check_single_value_form_input('contact-secondary-mail0', 'email22')
    check_single_value_form_input('contact-secondary-mail1', 'email21')
    check_single_value_form_input('contact-secondary-mail2', 'email23')

    check_form_selected_option('address-country', 'Estados_Unidos')
    check_single_value_form_input('address-zipcode', '123456789')
    check_single_value_form_input('address-state', 'Texas')

    check_form_checkbox_selected('relationship-associate', false)
    check_form_checkbox_selected('relationship-financial', true)
    check_form_checkbox_selected('relationship-mentoring', false)
    check_form_checkbox_selected('relationship-tutoring', true)
    check_single_value_form_input('relationship-remarks', 'obs 123')
  end

  test 'should fill profile' do
    initial_count = Person.count

    sign_in(@user3)
    post profile_index_url, params: {
      "person-name": 'Nova Pessoa',
      "person-gender": 'M',
      "person-birthdate": '1993-05-01',
      "person-cpf": '260.100.740-02',
      "person-rg": '5554443332',
      "contact-mobile": '(21) 77777-6666',
      "contact-facebook": 'fb333',
      "contact-linkedin": 'linkedin333',
      "contact-skype": 'skype333',
      "contact-preferred": 'E-mail',
      "no-content": '',
      "contact-secondary-mail0": 'email1@email.com',
      "contact-secondary-mail1": 'email2@email.com',
      "address-country": 'Brasil',
      "address-cep": '99.888-777',
      "address-zipcode": '99888777',
      "address-street": 'Rua Nova',
      "address-number": '999',
      "address-complement": 'CASA 01',
      "address-neighborhood": 'Bairro Novo',
      "address-city": 'Cidade Nova',
      "address-state": 'AC',
      "professional-company": 'Empresa Nova 1',
      "professional-position": 'Cargo Novo 1',
      "professional-admission-year": '2019',
      "professional-previous-company-name0": 'Empresa Antiga 111 teste',
      "professional-previous-company-name1": 'Empresa Antiga 222 teste',
      "education-level0": 'Graduação',
      "education-institution0": 'UFRJ',
      "education-course0": 'ECI',
      "education-conclusion-year0": '2017',
      "education-level1": 'Mestrado',
      "education-institution1": 'UFRJ',
      "education-course1": 'ECI2',
      "education-conclusion-year1": '2018',
      "relationship-financial": 'on',
      "relationship-tutoring": 'on',
      "relationship-remarks": 'obs teste 333',
      "commit": 'Enviar',
      "controller": 'profile',
      "action": 'create'
    }

    assert_redirected_to profile_index_url
    assert_equal 'Perfil atualizado com sucesso', flash[:notice]
    assert_equal initial_count + 1, Person.count

    follow_redirect!
    assert_response :success

    assert_select 'title', 'Informações Cadastrais | Instituto Reditus'

    check_single_value_form_input('person-name', 'Nova Pessoa')
    check_single_value_form_input('person-cpf', '26010074002')
    check_form_selected_option('person-gender', 'M')
    check_single_value_form_input('person-birthdate', '1993-05-01')
    check_single_value_form_input('person-rg', '5554443332')

    check_single_value_form_input('contact-mobile', '(21) 77777-6666')
    check_single_value_form_input('contact-facebook', 'fb333')
    check_single_value_form_input('contact-linkedin', 'linkedin333')
    check_single_value_form_input('contact-skype', 'skype333')
    check_form_selected_option('contact-preferred', 'E-mail')
    check_single_value_form_input('contact-secondary-mail0', 'email1@email.com')
    check_single_value_form_input('contact-secondary-mail1', 'email2@email.com')

    check_form_selected_option('address-country', 'Brasil')
    check_single_value_form_input('address-cep', '99888777')
    check_single_value_form_input('address-street', 'Rua Nova')
    check_single_value_form_input('address-number', '999')
    check_single_value_form_input('address-complement', 'CASA 01')
    check_single_value_form_input('address-neighborhood', 'Bairro Novo')
    check_single_value_form_input('address-city', 'Cidade Nova')
    check_single_value_form_input('address-state', 'AC')

    check_single_value_form_input('professional-company', 'Empresa Nova 1')
    check_single_value_form_input('professional-position', 'Cargo Novo 1')
    check_single_value_form_input('professional-admission-year', '2019')
    check_single_value_form_input('professional-previous-company-name0', 'Empresa Antiga 111 teste')
    check_single_value_form_input('professional-previous-company-name1', 'Empresa Antiga 222 teste')

    check_form_selected_option('education-level0', 'Graduação')
    check_single_value_form_input('education-institution0', 'UFRJ')
    check_single_value_form_input('education-course0', 'ECI')
    check_single_value_form_input('education-conclusion-year0', '2017')

    check_form_selected_option('education-level1', 'Mestrado')
    check_single_value_form_input('education-institution1', 'UFRJ')
    check_single_value_form_input('education-course1', 'ECI2')
    check_single_value_form_input('education-conclusion-year1', '2018')

    check_form_checkbox_selected('relationship-associate', false)
    check_form_checkbox_selected('relationship-financial', true)
    check_form_checkbox_selected('relationship-mentoring', false)
    check_form_checkbox_selected('relationship-tutoring', true)
    check_single_value_form_input('relationship-remarks', 'obs teste 333')
  end

  def check_single_value_form_input(input_name, value)
    assert_select 'form input[name=' + input_name + ']' do
      assert_select '[value=?]', value
    end
  end

  def check_form_selected_option(select_input_name, value)
    assert_select 'form select[name=' + select_input_name + ']' do
      assert_select 'option[selected=selected]' do
        assert_select '[value=?]', value
      end
    end
  end

  def check_form_checkbox_selected(checkbox_input_name, checked)
    assert_select 'form input[name=' + checkbox_input_name + '][type=checkbox]' + (checked ? '[checked]' : ''), 1
    if (!checked)
      # must also assert that it is not checked
      assert_select 'form input[name=' + checkbox_input_name + '][type=checkbox][checked]', 0
    end
  end
end
