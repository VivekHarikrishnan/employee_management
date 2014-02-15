class SessionsController < ApplicationController
	def new
	end

	def create		
		if params[:sessions][:empolyee_type] == "Admin"
			@employee = Employee.where(["code = ?", params[:sessions][:empolyee_code]]).first
		elsif params[:sessions][:empolyee_type] == "FullTimeEmployee"
			@employee = FullTimeEmployee.where(["code = ?", params[:sessions][:empolyee_code]]).first
		elsif params[:sessions][:empolyee_type] == "PartTimeEmployee"
			@employee = PartimeEmployee.where(["code = ?", params[:sessions][:empolyee_code]]).first
		end

		if @employee && @employee.authenticate(params[:sessions][:password])
		else
			flash.now[:error] = 'Invalid login credentials'
			render 'new'
		end
	end

	def destroy
	end
end