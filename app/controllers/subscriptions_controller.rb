class SubscriptionsController < ApplicationController
  def new
    @active_subscriptions = current_user.nil?? [] : current_user.subscriptions.where({active: true})
    @subscription = Subscription.new

    @country_list = Country.where(name: 'Brasil') # only brazilian addresses are allowed for subscriptions
    @address = current_user.nil?? nil : current_user.address
    @person = current_user.nil?? nil : current_user.person
  end

  def create
    user = current_user

    # if user is not logged in, try to get the user based on his email
    if user.nil?
      raise 'Os emails informados não batem' unless params['user-email'] == params['user-email-confirmation']

      user = User.where(:email => params['user-email']).first
    end

    # if there's no user with this email, create a new user
    isNewUser = false
    if user.nil?
      isNewUser = true
      user = User.new({:email => params['user-email'] })
      user.skip_password_validation = true
      user.save
      user.send_reset_password_instructions
    end

    # 1) create plan
    decimal_value = params[:subscription][:value].delete('.').gsub(',', '.').to_f
    integer_value = (decimal_value * 100).to_i
    @subscription = user.subscriptions.new(value: decimal_value, active: true)

    plan = PagarMe::Plan.new({
                               :name => 'Plano ' + ENV['SUBSCRIPTION_PERIOD_DAYS'] + ' dias - ' + decimal_value.to_s + ' reais - ' + user.email,
                               :days => ENV['SUBSCRIPTION_PERIOD_DAYS'].to_i,
                               :amount => integer_value,
                               :payment_methods => ['credit_card'],
                               :invoice_reminder => ENV['SUBSCRIPTION_INVOICE_REMINDER_DAYS'].to_i,
                             })
    plan.create

    # 2) create subscription
    pagarme_subscription = PagarMe::Subscription.new({
                                                       :payment_method => 'credit_card',
                                                       :card_number => params['card-number'],
                                                       :card_holder_name => params['card-holders-name']&.upcase,
                                                       :card_expiration_month => params['expiry-month'].rjust(2, '0'),
                                                       :card_expiration_year => '20' + params['expiry-year'],
                                                       :card_cvv => params['cvc'],
                                                       :postback_url => ENV['HOST_URL'].delete_suffix('/') + postback_index_path,
                                                       :customer => {
                                                         :name => params['person-name'],
                                                         :document_number => params['person-cpf'],
                                                         :email => user.email,
                                                         :address => {
                                                           :street => params['address-street'],
                                                           :neighborhood => params['address-neighborhood'],
                                                           :zipcode => params['address-cep'],
                                                           :street_number => params['address-number']
                                                         }
                                                       }
                                                     })
    pagarme_subscription.plan = plan
    pagarme_subscription.create

    if pagarme_subscription.status != 'paid'
      error_log = ErrorLog.new(category: 'pagarme_subscription', message: OpenStruct.new(pagarme_subscription.to_hash))
      error_log.save
      raise 'Ocorreu um erro na criação da assinatura. Entre em contato através do email contato@reditus.org.br'
    end

    @subscription.pagarme_identifier = pagarme_subscription.id
    @subscription.pagarme_subscription = OpenStruct.new(pagarme_subscription.to_hash)

    @payment = user.payments.new(value: decimal_value,
                                 pagarme_transaction: OpenStruct.new(pagarme_subscription.current_transaction.to_hash),
                                 subscription: @subscription)

    Payment.transaction do
      begin
        # HubSpot integration
        hubspotService = HubspotService.new
        hubspotService.create_deal(user, decimal_value, true, isNewUser)
      rescue => e
        Rails.logger.error e.message
        error_log = ErrorLog.new(category: 'hubspot_deal_subscription', message: e.message)
        error_log.save
      end

      if @payment.save
        ApplicationMailer.payment_confirmation_email(user, @payment).deliver_later
        flash[:notice] = 'Assinatura realizada com sucesso'
        if current_user.nil?
          redirect_to authenticated_root_path
        else
          redirect_to payments_path
        end
      end
    end
  rescue => e
    flash[:error] = e.message
    redirect_to new_subscription_path
  end
end
