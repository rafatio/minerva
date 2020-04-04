class PaymentService
  include PaymentsHelper

  @@reason_codes_obj = {missing_fields: 'MISSING_FIELDS'}

  def initialize(user)
    @user = user
  end

  def self.reason_codes
    return @@reason_codes_obj
  end

  def single_payment(params, isNewUser)

    decimal_value = params[:payment][:value].delete('.').gsub(',', '.').to_f
    @payment = @user.payments.new(value: decimal_value)

    if !params[:payment][:type].nil?
      payment_type = PaymentType.find_by  code: params[:payment][:type]
      raise 'Tipo de pagamento inválido' unless !payment_type.nil?
      @payment.payment_type = payment_type
    end

    country_name = params['address-country'].gsub('_',' ')
    country = Country.find_by_name(country_name)
    country_code = country.code

    if country_name == 'Brasil'
      zipcode = params['address-cep']
    else
      zipcode = params['address-zipcode']
    end

    transaction = PagarMe::Transaction.new(
        amount: (decimal_value * 100).to_i, # in cents
        card_number: params['card-number'],
        card_holder_name: params['card-holders-name']&.upcase,
        card_expiration_month: params['expiry-month'].rjust(2, '0'),
        card_expiration_year: '20' + params['expiry-year'],
        card_cvv: params['cvc'],
        payment_method: 'credit_card',
        async: false,
        customer: {
            external_id: @user.id.to_s,
            name: params['person-name'],
            type: 'individual',
            country: country_code,
            email: @user.email,
            documents: [
            {
                type: 'cpf',
                number: params['person-cpf'].delete('.-')

            }
            ],
            phone_numbers: [ params['person-phone'].delete('() -')],
        },
        billing: {
            name: params['person-name'],
            address: {
            country: country_code,
            state: params['address-state'],
            city: params['address-city'],
            neighborhood: params['address-neighborhood'],
            street: params['address-street'],
            street_number: params['address-number'],
            zipcode: zipcode.delete('.-')
            }
        },
        items: [
            {
            id: 'Contrib-Unica-' + SecureRandom.uuid,
            title: 'Contribuição única ' + params['person-name'] + ' ' + decimal_value.to_s,
            unit_price: (decimal_value * 100).to_i,
            quantity: 1,
            tangible: false
            }
        ]
    )

    charged_transaction = transaction.charge
    charged_transaction_hash = charged_transaction.to_hash
    @payment.pagarme_transaction = OpenStruct.new(charged_transaction_hash)

    if transaction.status != 'paid'
      error_log = ErrorLog.new(category: 'pagarme_transaction', message: @payment.pagarme_transaction)
      error_log.save
      raise 'Ocorreu um erro no pagamento. Entre em contato através do email contato@reditus.org.br'
    end

    begin
      # HubSpot integration
      hubspotService = HubspotService.new
      hubspotService.create_deal(@user, decimal_value, false, isNewUser)
    rescue => e
      Rails.logger.error e.message
      error_log = ErrorLog.new(category: 'hubspot_deal_transaction', message: e.message)
      error_log.save
    end

    save_ok = @payment.save
    response = {
        success: save_ok,
        payment: @payment,
        message: ''
    }
    return response
  end

end
