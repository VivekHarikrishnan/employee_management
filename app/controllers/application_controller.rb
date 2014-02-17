class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_employee

  def require_login
  	if current_employee.present?
      if params[:controller] == "projects" || params[:controller] == "project_tasks"
        redirect_to home_path if !current_employee.is?("Admin")
      end

      if params[:controller] == "employees"
        if !current_employee.is?("Admin") && !(["manage_account", "update_password"].include?(params[:action]))
          redirect_to home_path
        end
      end
    else
      redirect_to root_path
    end
  end

  private
  def current_employee    
  	Employee.where("id = #{session[:employee_session_token]}").first if session[:employee_session_token]
  end
end
