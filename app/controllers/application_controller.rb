class ApplicationController < ActionController::Base
    before_action :set_locale


    def set_locale
        if [RailsAdmin].include?(self.class.parent)
            I18n.locale = :en
        else
            I18n.locale = params[:locale] || I18n.default_locale
        end
    end
end
