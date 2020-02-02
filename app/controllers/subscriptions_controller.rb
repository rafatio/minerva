class SubscriptionsController < ApplicationController
    before_action :authenticate_user!

    def new
        if current_user.address.nil?
          flash[:error] = "É necessário completar seu cadastro antes de realizar uma assinatura."
          redirect_to profile_index_path
        end

        @active_subscriptions = current_user.subscriptions.where({active: true})
        @subscription = Subscription.new
    end

    def create

        #1) create plan
        decimal_value = params[:subscription][:value].delete('.').gsub(",", ".").to_f
        integer_value = (decimal_value * 100).to_i
        @subscription = current_user.subscriptions.new(value: decimal_value, active:true)

        plan = PagarMe::Plan.new({
            :name => "Plano " + ENV["SUBSCRIPTION_PERIOD_DAYS"] + " dias - " + decimal_value.to_s + " reais - " + current_user.email,
            :days => ENV["SUBSCRIPTION_PERIOD_DAYS"].to_i,
            :amount => integer_value,
            :payment_methods => ["credit_card"],
            :invoice_reminder => ENV["SUBSCRIPTION_INVOICE_REMINDER_DAYS"].to_i,
        })
        plan.create

        #2) create subscription
        pagarme_subscription = PagarMe::Subscription.new({
            :payment_method => 'credit_card',
            :card_number => params['card-number'],
            :card_holder_name => params['card-holders-name']&.upcase,
            :card_expiration_month => params['expiry-month'].rjust(2, '0'),
            :card_expiration_year => '20' + params['expiry-year'],
            :card_cvv => params['cvc'],
            :postback_url => ENV["HOST_URL"].delete_suffix('/') + postback_index_path,
            :customer => {
                :name => current_user.person&.name,
                :document_number => current_user.person&.cpf,
                :email => current_user.email,
                :address => {
                    :street => current_user.address&.street,
                    :neighborhood => current_user.address&.neighborhood,
                    :zipcode => current_user.address&.zip_code,
                    :street_number => current_user.address&.number
                }
            }
        })
        pagarme_subscription.plan = plan
        pagarme_subscription.create

        if pagarme_subscription.status != 'paid'
            error_log = ErrorLog.new(category: "pagarme_subscription", message: OpenStruct.new(pagarme_subscription.to_hash))
            error_log.save
            raise "Ocorreu um erro na criação da assinatura. Entre em contato através do email contato@reditus.org.br"
        end

        @subscription.pagarme_identifier = pagarme_subscription.id
        @subscription.pagarme_subscription = OpenStruct.new(pagarme_subscription.to_hash)

        @payment = current_user.payments.new(value: decimal_value,
                                            pagarme_transaction: OpenStruct.new(pagarme_subscription.current_transaction.to_hash),
                                            subscription: @subscription)

        Payment.transaction do

            begin
                HubspotService.new.create_deal(current_user, decimal_value, true)
            rescue => e
                Rails.logger.error e.message
                error_log = ErrorLog.new(category: "hubspot_deal_subscription", message: e.message)
                error_log.save
            end

            if @payment.save
                ApplicationMailer.payment_confirmation_email(current_user, @payment).deliver_later
                flash[:notice] = 'Assinatura realizada com sucesso'
                redirect_to payments_path
            end
        end

    rescue => e
        flash[:error] = e.message
        redirect_to new_subscription_path
    end


end
