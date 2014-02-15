module SessionsHelper
	def save_session_details employee
		session[:employee_session_token] = employee.id 
	end

	def destroy_session_details
		session[:employee_session_token] = nil
	end
end
