class PaymentsController < ApplicationController
  before_action :authenticate_user!, only: [:index]

  def index
    @payments = current_user.payments.reverse
  end

  def new
    @payment = Payment.new
  end

  def create
    user = current_user

    # if user is not logged in, try to get the user based on his email
    if user.nil?
      raise 'Os emails informados não batem' unless params['user-email'] == params['user-email-confirmation']

      user = User.where(:email => params['user-email']).first
    end

    # if there's no user with this email, create a new user
    if user.nil?
      user = User.new({:email => params['user-email'] })
      user.skip_password_validation = true
      user.save
      user.send_reset_password_instructions
    end

    decimal_value = params[:payment][:value].delete('.').gsub(",", ".").to_f
    @payment = user.payments.new(value: decimal_value)

    transaction = PagarMe::Transaction.new(
      amount: (decimal_value * 100).to_i, # in cents
      card_number: params['card-number'],
      card_holder_name: params['card-holders-name']&.upcase,
      card_expiration_month: params['expiry-month'].rjust(2, '0'),
      card_expiration_year: '20' + params['expiry-year'],
      card_cvv: params['cvc'],
    )

    @payment.pagarme_transaction = OpenStruct.new(transaction.charge.to_hash)

    if transaction.status != 'paid'
      error_message = TranslateAcquirerResponse.call(code: transaction.acquirer_response_code).message

      if error_message.blank?
        error_message = "Erro inesperado - #{transaction.status_reason}"
      end

      raise "Ocorreu um erro no pagamento. Causa: #{error_message}"
    end

    if @payment.save
      ApplicationMailer.payment_confirmation_email(user, @payment).deliver_later
      flash[:notice] = 'Pagamento realizado com sucesso'
      if current_user.nil?
        redirect_to root_path
      else
        redirect_to payments_path
      end

    end
  rescue => e
    flash[:error] = e.message
    redirect_to new_payment_path
  end

  private

  def payment_params
    params.require(:payment).permit(:value)
  end
end