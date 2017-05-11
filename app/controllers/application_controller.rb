class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception
  # before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :set_locale

  # protected

  #   def configure_permitted_parameters
  #     devise_parameter_sanitizer.for(:sign_up) << :name
  #     devise_parameter_sanitizer.for(:account_update) << :name
  #   end
  # rescue_from CanCan::AccessDenied do |exception|
  #   flash[:error] = "Access denied!"
  #   redirect_to root_url
  # end
  rescue_from CanCan::AccessDenied do |exception|
    # render :file => "#{Rails.root}/public/403.html", :status => 403, :layout => false
    # render(:status => 403)
    redirect_to error_403_path
    ## to avoid deprecation warnings with Rails 3.2.x (and incidentally using Ruby 1.9.3 hash syntax)
    ## this render call should be:
    # render file: "#{Rails.root}/public/403", formats: [:html], status: 403, layout: false
  end

  private

    def set_locale
      # I18n.locale = params[:locale] || I18n.default_locale
      # Rails.application.routes.default_url_options[:locale] = I18n.locale 
      # I18n.locale = extract_locale_from_accept_language_header
      # Rails.application.routes.default_url_options[:locale] = I18n.locale 
      # if params[:locale].blank?
      #   # redirect_to "/#{extract_locale_from_accept_language_header}"
      # else
      #   I18n.locale = params[:locale]
      # end
      I18n.locale = params[:locale] || ((lang = request.env['HTTP_ACCEPT_LANGUAGE']) && lang[/^[a-z]{2}/])
      Rails.application.routes.default_url_options[:locale] = I18n.locale
    end
    
    # def extract_locale_from_accept_language_header
    #   # request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first.presence || 'es'
    #   case request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
    #     when 'eu'
    #       'eu'
    #     when 'es'
    #       'es'
    #     when 'en'
    #       'en'
    #     else
    #       'en'
    #   end
    # end
end
