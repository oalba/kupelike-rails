class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception
  # before_filter :configure_permitted_parameters, if: :devise_controller?

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
    render :file => "#{Rails.root}/public/403.html", :status => 403, :layout => false
    ## to avoid deprecation warnings with Rails 3.2.x (and incidentally using Ruby 1.9.3 hash syntax)
    ## this render call should be:
    # render file: "#{Rails.root}/public/403", formats: [:html], status: 403, layout: false
  end
end
