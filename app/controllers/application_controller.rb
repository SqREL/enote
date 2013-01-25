class ApplicationController < ActionController::Base
  protect_from_forgery

  def current_user
    @current_user ||= if params[:api_key]
                        User.find_by_api_key(params[:api_key])
                      else
                        User.find(session[:user_id]) if session[:user_id]
                      end
  end

  def sign_in
    render page_path("home") unless current_user
  end

  helper_method :current_user
end
