class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_employee

  def require_login
  	redirect_to root_path unless current_employee.present?
  end

  private
  def current_employee    
  	Employee.where("id = #{session[:employee_session_token]}").first if session[:employee_session_token]
  end
end
