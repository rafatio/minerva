class PaymentService
    include PaymentsHelper

    @@reason_codes_obj = {missing_fields: "MISSING_FIELDS"}

    def initialize(user)
        @user = user
    end

    def self.reason_codes
        return @@reason_codes_obj
    end

    def single_payment(params)

        validation_result = validate_user_required_fields_for_payment(@user)

        if !validation_result[:valid]
            response = {
                success: false,
                message: validation_result[:message],
                reason_code: @@reason_codes_obj[:missing_fields]
            }
            return response
        end


        decimal_value = params[:payment][:value].delete('.').gsub(",", ".").to_f
        @payment = @user.payments.new(value: decimal_value)

        if !params[:payment][:type].nil?
            payment_type = PaymentType.find_by  code: params[:payment][:type]
            raise 'Tipo de pagamento inválido' unless !payment_type.nil?
            @payment.payment_type = payment_type
        end

        transaction = PagarMe::Transaction.new(
            amount: (decimal_value * 100).to_i, # in cents
            card_number: params['card-number'],
            card_holder_name: params['card-holders-name']&.upcase,
            card_expiration_month: params['expiry-month'].rjust(2, '0'),
            card_expiration_year: '20' + params['expiry-year'],
            card_cvv: params['cvc'],
            payment_method: "credit_card",
            async: false,
            customer: {
                external_id: @user.id.to_s,
                name: @user.person.name,
                type: "individual",
                country: @user.address.country.code,
                email: @user.email,
                documents: [
                {
                    type: "cpf",
                    number: @user.person.cpf

                }
                ],
                phone_numbers: ["+55" + validation_result[:mobile_phone_contact].value.delete('() -')],
            },
            billing: {
                name: @user.person.name,
                address: {
                country: @user.address.country.code,
                state: @user.address.state.nil?? @user.address.state_name : @user.address.state.code,
                city: @user.address.city,
                neighborhood: @user.address.neighborhood,
                street: @user.address.street,
                street_number: @user.address.number,
                zipcode: @user.address.zip_code
                }
            },
            items: [
                {
                id: "Contrib-Unica-" + SecureRandom.uuid,
                title: "Contribuição única " + @user.person.name + " " + decimal_value.to_s,
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
            error_log = ErrorLog.new(category: "pagarme_transaction", message: @payment.pagarme_transaction)
            error_log.save
            raise "Ocorreu um erro no pagamento. Entre em contato através do email contato@reditus.org.br"
        end

        begin
            HubspotService.new.create_deal(@user, decimal_value, false)
        rescue => e
            Rails.logger.error e.message
            error_log = ErrorLog.new(category: "hubspot_deal_transaction", message: e.message)
            error_log.save
        end

        save_ok = @payment.save
        response = {
            success: save_ok,
            payment: @payment,
            message: ""
        }
        return response
    end

end