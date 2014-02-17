module Api
  module V1
  	class ApplicationController < ActionController::Base
       before_filter :verify_authorized_access
       
       private
	   def unautorized
		head :unauthorized		
	   end

	   def verify_authorized_access
	   	authenticate_or_request_with_http_token do |token, options|
	   		emp_code, password = token.split("&")
	   		if emp_code.present? && password.present?
	   			employee = Employee.where(["code = ?", emp_code]).first
	   			if employee && employee.authenticate(password)
	   				true
	   			else
				  unautorized
	   			end
	   		else
	   			unautorized
	   		end
	   	end	   	
	   end
  	end
  end
end