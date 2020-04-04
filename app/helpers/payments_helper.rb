module PaymentsHelper
  def format_currency value
    value == 0 ? '-' : number_to_currency(value, unit: 'R$ ', separator: ',')
  end

  def validate_user_required_fields_for_payment(user)
    incomplete_registration = false
    required_fields = []
    error_message = ''

    contacts_service = ContactsService.new(user)
    mobile_phone_contact = contacts_service.get_contacts('Celular')

    if user.person.nil?
      incomplete_registration = true
      required_fields.push('Dados Pessoais')
    else
      if user.person.name.nil?
        incomplete_registration = true
        required_fields.push('Nome')
      end
      if user.person.cpf.nil?
        incomplete_registration = true
        required_fields.push('CPF')
      end
    end

    if user.address.nil?
      incomplete_registration = true
      required_fields.push('Endereço')
    else
      if user.address.country.nil? || user.address.country.code.nil?
        incomplete_registration = true
        required_fields.push('País')
      end
      if user.address.state.nil? && user.address.state_name.nil?
        incomplete_registration = true
        required_fields.push('Estado')
      end
      if user.address.city.nil?
        incomplete_registration = true
        required_fields.push('Cidade')
      end
      if user.address.neighborhood.nil?
        incomplete_registration = true
        required_fields.push('Bairro')
      end
      if user.address.street.nil?
        incomplete_registration = true
        required_fields.push('Logradouro')
      end
      if user.address.number.nil?
        incomplete_registration = true
        required_fields.push('Número (Endereço)')
      end
      if user.address.zip_code.nil?
        incomplete_registration = true
        required_fields.push('CEP')
      end
    end

    if mobile_phone_contact.count == 0
      incomplete_registration = true
      required_fields.push('Celular')
    end

    if incomplete_registration
      error_message = 'Os seguintes campos são obrigatórios para a contribuição: ' + required_fields.join(', ')
    end

    response = {valid: !incomplete_registration, message: error_message, mobile_phone_contact: mobile_phone_contact.first}
    return response
  end

end
