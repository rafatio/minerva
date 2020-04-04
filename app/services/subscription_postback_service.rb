# frozen_string_literal: true

class SubscriptionPostbackService
  def initialize; end

  def process_status_changed_postback(status_changed_params)
    subscription_id = status_changed_params[:id]
    raise 'O id da assinatura não foi informado' if subscription_id.empty?

    subscription = Subscription.find_by(pagarme_identifier: subscription_id)
    raise 'Assinatura não encontrada' if subscription.nil?

    any_changes = false

    new_status = status_changed_params[:current_status]
    if new_status == 'canceled'
      subscription[:active] = false
      any_changes = true
    end

    if !any_changes
      'Nenhuma ação feita - O novo status da assinatura não é tratado'
    elsif subscription.save
      'Assinatura atualizada com sucesso'
    else
      raise 'Erro ao atualizar assinatura'
    end
  end
end
