class PaymentsController < ApplicationController
  before_action :authenticate_user!, only: :index

  def index
    @payments = current_user.payments.reverse
  end

  def new
    @payment = Payment.new
  end

  def create
    payment = current_user.payments.new(payment_params)

    transaction = PagarMe::Transaction.new(
      amount: (params[:payment][:value].to_f * 100), # in cents
      card_hash: params[:payment][:card_hash],
    )
    payment.pagarme_transaction = OpenStruct.new(transaction.charge.to_hash)
    raise "Erro no pagamento devido a: #{transaction.status_reason}" unless transaction.status == "paid"

    if payment.save
      flash[:notice] = "Pagamento criado"
      redirect_to payments_path
    else
      flash[:error] = "Erro no pagamento"
      redirect_to new_payment_path
    end
  rescue => e
    flash[:error] = e.message
    redirect_to new_payment_path
  end

  private

  def payment_params
    params.require(:payment).permit(:user_id, :value)
  end
end

