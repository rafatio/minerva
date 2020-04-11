# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    @ambassadors = Ambassador.all
    super
  end

  # POST /resource
  def create
    if params[:agreement] != '1'
      flash[:error] = 'É necessário aceitar os temos e condições'
      redirect_to new_user_registration_url
      return
    end

    User.transaction do
      super

      user_email = params[:user][:email]
      ambassador_id = params[:ambassador]
      if !ambassador_id.blank?
        ambassador_id = ambassador_id.to_i
        response = UserService.new.assign_ambassador(user_email, ambassador_id)
        if !response[:success]
          flash[:notice] = nil
          Rails.logger.error response[:message]
          flash[:error] = 'Erro inesperado ao associar embaixador. Entre em contato com o suporte'
          raise ActiveRecord::Rollback
          return
        end

      end

      # HubSpot integration
      HubspotService.new.create_contact(user_email)
    end
  rescue Hubspot::RequestError => e
    flash[:notice] = nil
    Rails.logger.error e.message
    flash[:error] = 'Erro inesperado. Entre em contato com o suporte'
  rescue Exception => e
    Rails.logger.error e.message
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
