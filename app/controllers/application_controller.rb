class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_locale
  layout :layout_by_resource

  def layout_by_resource
    if devise_controller? and controller_name != "users"
      "devise"
    else
      "application"
    end
  end
  
  def set_locale
    I18n.locale = session[:language] || SystemConfiguration.first.language
  end
  
end