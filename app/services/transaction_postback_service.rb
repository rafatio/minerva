class TransactionPostbackService
    def initialize

    end

    def process_transaction_postback(transaction_params)
        raise 'A transação não foi paga' unless transaction_params[:status] == "paid"
        subscription_id = transaction_params[:subscription_id]
        if (!subscription_id.empty?)
            #we need to create a new payment and link it to the corresponding subscription
            subscription = Subscription.find_by_pagarme_identifier(subscription_id)
            raise 'Assinatura não encontrada' unless !subscription.nil?

            decimal_value = transaction_params[:amount].to_f / 100.0
            user = subscription.user
            payment_type = PaymentType.find_by  code: 'normal'
            payment = user.payments.new(value: decimal_value,
                pagarme_transaction: OpenStruct.new(transaction_params.to_hash),
                subscription: subscription,
                payment_type: payment_type)


            if payment.save
                ApplicationMailer.payment_confirmation_email(user, payment).deliver_later
            else
                raise 'Erro ao salvar o pagamento'
            end

            return 'Pagamento inserido'

        end

        return 'Nenhuma ação feita - Pagamento sem assinatura'
    end
end