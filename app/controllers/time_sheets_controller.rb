class TimeSheetsController < ApplicationController
	before_filter :require_login
	before_action :set_time_sheet, only: [:edit, :update, :destroy]

	def index
		if params[:history]
			@time_sheets = current_employee.all_time_sheets
		else
			@time_sheets = current_employee.time_sheets
		end
		@projects = current_employee.projects
		@project_tasks = ProjectTask.all
		@time_sheet = TimeSheet.new
	end

	def create
		employees_projects = current_employee.employees_projects.where(["project_id = ?", params[:time_sheet][:project_id]]).first
		if employees_projects
			params[:time_sheet][:employees_projects_id] = employees_projects.id
			@time_sheet = TimeSheet.create(time_sheet_params)
		else
			@time_sheet = TimeSheet.new
		end
		# @time_sheets.map(&:employee)
		@time_sheets = current_employee.time_sheets
		@projects = current_employee.projects
		# @projects.map(&:name)
		@project_tasks = ProjectTask.all
		# @time_sheet = TimeSheet.new
	end

	def edit

	end

	def update
		if params[:cancel]
			# Do nothing			
		else
			if params[:time_sheet]
				alter_from_and_to_time				
				@time_sheet.update_attributes(update_params)				
			else
				# Do nothing
			end
		end
	end

	def destroy
		@time_sheet.destroy
	end

	private
	def set_time_sheet
		@time_sheet = TimeSheet.find params[:id]
	end

	def update_params
		params.require(:time_sheet).permit(:from_time, :to_time)
	end

	def time_sheet_params
		params[:time_sheet][:date_of_sheet] = "#{params[:time_sheet]["date_of_sheet(1i)"]}-#{params[:time_sheet]["date_of_sheet(2i)"]}-#{params[:time_sheet]["date_of_sheet(3i)"]}"
		alter_from_and_to_time		
		params.require(:time_sheet).permit(:employees_projects_id, :project_task_id, :date_of_sheet, :from_time, :to_time)
	end

	def alter_from_and_to_time
		params[:time_sheet][:from_time] = "#{params[:time_sheet]["from_time(4i)"]}:#{params[:time_sheet]["from_time(5i)"]}"
		params[:time_sheet][:to_time] = "#{params[:time_sheet]["to_time(4i)"]}:#{params[:time_sheet]["to_time(5i)"]}"
	end
end