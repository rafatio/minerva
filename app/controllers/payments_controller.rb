class PaymentsController < ApplicationController
  before_action :authenticate_user!, only: :index

  def index
    @payments = current_user.payments.reverse
  end

  def new
    @payment = Payment.new
  end

  def create
    @payment = current_user.payments.new(payment_params)

    transaction = PagarMe::Transaction.new(
      amount: (params[:payment][:value].to_f * 100), # in cents
      card_number: params["card-number"],
      card_holder_name: params["card-holders-name"]&.upcase,
      card_expiration_month: params["expiry-month"].rjust(2, '0'),
      card_expiration_year: "20" + params["expiry-year"],
      card_cvv: params["cvc"],
    )
    @payment.pagarme_transaction = OpenStruct.new(transaction.charge.to_hash)

    if transaction.status != "paid"
      error_message = ""
      if not transaction.acquirer_response_code.nil?
        response_code = AcquirerResponseCode.where(:code => transaction.acquirer_response_code)
        if response_code.count > 0
          error_message = response_code[0].message
        else
          error_message = "Erro inesperado - #{transaction.status_reason}"
        end
      else
        error_message = "Erro inesperado - #{transaction.status_reason}"
      end

      raise "Ocorreu um erro no pagamento. Causa: #{error_message}"
    end

    if @payment.save
      flash[:notice] = "Pagamento realizado com sucesso"
      redirect_to payments_path
    end
  rescue => e
    flash[:error] = e.message
    redirect_to new_payment_path
  end

  private

  def payment_params
    params.require(:payment).permit(:user_id, :value, :card_hash)
  end
end