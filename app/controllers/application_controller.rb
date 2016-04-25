class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :logged_in?, :current_user, :tutor?

  def logged_in?
    session[:user_id]
  end

  def current_user
    if session[:tutor]
      Tutor.find(session[:user_id]) if logged_in?
    else
      Student.find(session[:user_id]) if logged_in?
    end
  end

  def tutor?
    session[:tutor]
  end
end
