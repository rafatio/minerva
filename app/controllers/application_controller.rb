# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :set_locale

  layout :layout_by_resource

  def set_locale
    if [RailsAdmin].include?(self.class.parent)
      I18n.locale = :en
    else
      I18n.locale = params[:locale] || I18n.default_locale
    end
  end

  def blazer_authentication
    if current_user.nil?
        head 401
    elsif current_user.admin?
        # OK
    elsif params[:controller].downcase != "blazer/queries"
        head 403 #for now, we are mapping only the query actions
    else
        if params[:action].downcase == "new" || params[:action].downcase == "show" || params[:action].downcase == "home"
            # basic methods. User must have the "Show" role
            if current_user.roles.where(:name => Role.Constants[:show_reports]).count == 0
                head 403
            end

        elsif params[:action].downcase == "create"
            if  current_user.roles.where(:name => Role.Constants[:create_reports]).count == 0
                head 403
            end

        elsif params[:action].downcase == "run"
            if current_user.roles.where(:name => Role.Constants[:run_reports]).count > 0
                #OK
            elsif params[:query_id].nil?
                head 403
            else
                query = BlazerQuery.find(params[:query_id])
                if query.nil? || query.run_role_id.nil? || current_user.roles.where(:id => query.run_role_id).count == 0
                    head 403
                end
            end
        elsif params[:action].downcase == "edit" || params[:action].downcase == "update"
            if current_user.roles.where(:name => Role.Constants[:update_reports]).count > 0
                #OK
            elsif params[:id].nil?
                head 403
            else
                query_id = params[:id].split(/-/).first
                query = BlazerQuery.find(query_id)
                if query.nil? || query.update_role_id.nil? || current_user.roles.where(:id => query.update_role_id).count == 0
                    head 403
                end
            end
        elsif params[:action].downcase == "destroy"
            if current_user.roles.where(:name => Role.Constants[:delete_reports]).count > 0
                #OK
            elsif params[:id].nil?
                head 403
            else
                query_id = params[:id].split(/-/).first
                query = BlazerQuery.find(query_id)
                if query.nil? || query.delete_role_id.nil? || current_user.roles.where(:id => query.delete_role_id).count == 0
                    head 403
                end
            end
        else
            # unmapped actions
            head 403
        end

    end

end

  private

  def layout_by_resource
    if devise_controller?
      'devise'
    else
      'application'
    end
  end
end
