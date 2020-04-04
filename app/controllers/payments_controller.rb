# frozen_string_literal: true

class PaymentsController < ApplicationController
  before_action :authenticate_user!, only: [:index]

  def index
    @payments = current_user.payments.reverse
    @subscriptions = current_user.subscriptions.reverse
  end

  def new
    @payment = Payment.new
    if !params[:type].nil?
      payment_type = PaymentType.find_by code: params[:type]
      raise 'Tipo de pagamento inválido' unless !payment_type.nil?

      @payment.payment_type = payment_type
    end
    @country_list = Country.all
    @address = current_user.nil? ? nil : current_user.address
    @person = current_user.nil? ? nil : current_user.person
    contacts_service = ContactsService.new(current_user)
    @mobile_contact = current_user.nil? ? nil : contacts_service.get_contacts('Celular').first
  rescue => e
    flash[:error] = e.message
    redirect_to new_payment_path
  end

  def create
    user = current_user

    # if user is not logged in, try to get the user based on his email
    if user.nil?
      raise 'Os emails informados não batem' unless params['user-email'] == params['user-email-confirmation']

      user = User.where(email: params['user-email']).first
    end

    isNewUser = false
    # if there's no user with this email, create a new user
    if user.nil?
      isNewUser = true
      user = User.new({ email: params['user-email'] })
      user.skip_password_validation = true
      user.save
      user.send_reset_password_instructions
    end

    payment_service = PaymentService.new(user)
    service_response = payment_service.single_payment(params, isNewUser)

    if service_response[:success]
      ApplicationMailer.payment_confirmation_email(user, service_response[:payment]).deliver_later
      flash[:notice] = 'Pagamento realizado com sucesso'
      if current_user.nil?
        redirect_to authenticated_root_path
      else
        redirect_to payments_path
      end
    else
      flash[:error] = service_response[:message]
      if !service_response[:reason_code].nil? && service_response[:reason_code] == PaymentService.reason_codes[:missing_fields]
        redirect_to profile_index_path
      else
        redirect_to new_payment_path
      end
    end
  rescue => e
    flash[:error] = e.message
    if params[:payment][:type].nil?
      redirect_to new_payment_path
    else
      redirect_to new_payment_path(type: params[:payment][:type])
    end
  end

  private

  def payment_params
    params.require(:payment).permit(:value)
  end
end
