class SessionsController < ApplicationController
	include SessionsHelper
	def new
		redirect_to home_path if current_employee
	end

	def create		
		if params[:sessions][:employee_type] == "Admin"
			@employee = Employee.where(["type = ? AND code = ?", 'Admin', params[:sessions][:employee_code]]).first
		elsif params[:sessions][:employee_type] == "FullTimeEmployee"
			@employee = FullTimeEmployee.where(["code = ?", params[:sessions][:employee_code]]).first
		elsif params[:sessions][:employee_type] == "PartTimeEmployee"
			@employee = PartTimeEmployee.where(["code = ?", params[:sessions][:employee_code]]).first
		end

		if @employee && @employee.authenticate(params[:sessions][:password])
			save_session_details @employee
			redirect_to home_path
		else
			flash.now[:error] = 'Invalid login credentials'
			render 'new'
		end
	end

	def destroy
		destroy_session_details
		redirect_to root_path
	end
end