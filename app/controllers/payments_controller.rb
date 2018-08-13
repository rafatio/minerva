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
      card_number: params[:payment][:card_number],
      card_holder_name: params[:payment][:card_holder_name]&.camelcase,
      card_expiration_month: params[:payment][:card_expiration_month],
      card_expiration_year: params[:payment][:card_expiration_year],
      card_cvv: params[:payment][:card_cvv],
    )
    @payment.pagarme_transaction = OpenStruct.new(transaction.charge.to_hash)
    raise "Ocorreu um erro no pagamento. Causa: #{transaction.status_reason}" unless transaction.status == "paid"

    if @payment.save
      flash[:notice] = "Pagamento criado"
      redirect_to payments_path
    else
      flash[:error] = "Erro no pagamento"
      redirect_to new_payment_path
    end
  rescue => e
    flash.now[:error] = e.message
    render :new
  end

  private

  def payment_params
    params.require(:payment).permit(:user_id, :value)
  end
end

