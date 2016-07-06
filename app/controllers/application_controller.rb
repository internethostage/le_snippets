class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # def authenticate_user!
  #   redirect_to new_session_path, notice: "Please sign in to continue" unless user_signed_in?
  # end

  def authenticate_user!(return_point = request.url)
    unless user_signed_in?
      set_return_point(return_point)
      redirect_to new_session_path, notice: "Please sign in to continue"
    end
  end

  def set_return_point(path, overwrite = false)
    if overwrite or session[:return_point].blank?
      session[:return_point] = path
    end
  end

  def return_point
    session[:return_point] || root_path
  end

  def user_signed_in?
    current_user.present?
  end
  helper_method :user_signed_in?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

end
