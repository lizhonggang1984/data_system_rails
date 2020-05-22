class ApplicationController < ActionController::Base
  def check_login
    # @current_user ||= session[:account_id] && Account.find(session[:account_id])
    @current_user ||= cookies[:auth_token] && Account.find_by(auth_token:cookies[:auth_token])
  end
end
