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
  
  private

  def layout_by_resource
    if devise_controller?
      "devise"
    else
      "application"
    end
  end
end
