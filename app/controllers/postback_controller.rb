class PostbackController < ApplicationController
    skip_before_action :verify_authenticity_token

    def create
      if valid_postback?
        result = ''
        if params[:object] == "subscription" && params[:event] == "transaction_created"
          postback_service = TransactionPostbackService.new
          result = postback_service.process_transaction_postback(transaction_params)
        elsif params[:object] == "subscription" && params[:event] == "subscription_status_changed"
          postback_service = SubscriptionPostbackService.new
          result = postback_service.process_status_changed_postback(subscription_status_changed_params)
        else
          result = 'Tipo de postback não tratado'
        end
        render_valid_postback_response(result)
      else
        render_invalid_postback_response('Postback inválido')
      end

    rescue => e
      render_invalid_postback_response(e.message)
    end

    protected
    def valid_postback?
      raw_post  = request.raw_post
      signature = request.headers['HTTP_X_HUB_SIGNATURE']
      PagarMe::Postback.valid_request_signature?(raw_post, signature)
    end

    def render_invalid_postback_response(message)
      render json: {error: message}, status: 400
    end

    def render_valid_postback_response(message)
        render json: {message: message}, status: 200
    end

    def transaction_params
        params.require(:subscription).require(:current_transaction).permit!
    end

    def subscription_status_changed_params
        params.permit(:id, :old_status, :current_status)
    end

  end