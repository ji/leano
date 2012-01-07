class ApplicationController < ActionController::Base
  before_filter :fetch_logged_user
  
  protect_from_forgery
  
protected
  
  def fetch_logged_user
    unless session[:user_id].nil?
      @logged_user = User.find(session[:user_id])
    end
    rescue ActiveRecord::RecordNotFound
  end
  
  
  def check_authenticated_user
      unless @logged_user
        # unauthorized access
        redirect_to login_url, notice: "You need to login to view this content."
        return false
      end
    end
end
