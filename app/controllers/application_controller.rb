# provides functionaility for all controllers
class ApplicationController < ActionController::Base

  # Prevent CSRF attacks by raising an exception.
  protect_from_forgery with: :exception

  # Include our session helper
  include SessionHelper

  def authenticate_user
    redirect_to login_path, status: 403 unless current_user
  end
end
