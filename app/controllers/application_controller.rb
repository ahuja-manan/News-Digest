class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Include our session helper
  include SessionHelper

  def authenticate_user
  	if !current_user
  		redirect_to login_path, status: 403
  	end
  end
end