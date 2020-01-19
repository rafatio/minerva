# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    super
  end

  # POST /resource
  def create

    User.transaction do
      super

      # HubSpot integration
      # we use the "create_or_update" method because the user may have entered an email that is already in use
      # in this case, we will call the hubspot update method, passing no properties whatsoever
      # since the only properties that are updated are the ones that we pass, in reality nothing will happen
      contact = Hubspot::Contact.create_or_update!([{email: params[:user][:email]}])
    end
    rescue Hubspot::RequestError => e
      flash[:notice] = nil
      Rails.logger.error e.message
      flash[:error] = "Erro inesperado. Entre em contato com o suporte"
    rescue Exception => ex
      Rails.logger.error ex.message
      raise
  end

  # GET /resource/edit
  def edit
    super
  end

  # PUT /resource
  def update
    super
  end

  # DELETE /resource
  def destroy
    super
  end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  def cancel
    super
  end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  end

  # The path used after sign up.
  def after_sign_up_path_for(resource)
    super(resource)
  end

  # The path used after sign up for inactive accounts.
  def after_inactive_sign_up_path_for(resource)
    super(resource)
  end
end
