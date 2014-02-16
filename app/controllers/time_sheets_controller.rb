class TimeSheetsController < ApplicationController
	before_filter :require_login

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

	private
	def time_sheet_params
		params[:time_sheet][:date_of_sheet] = "#{params[:time_sheet]["date_of_sheet(1i)"]}-#{params[:time_sheet]["date_of_sheet(2i)"]}-#{params[:time_sheet]["date_of_sheet(3i)"]}"
		params[:time_sheet][:from_time] = "#{params[:time_sheet]["from_time(4i)"]}:#{params[:time_sheet]["from_time(5i)"]}"
		params[:time_sheet][:to_time] = "#{params[:time_sheet]["to_time(4i)"]}:#{params[:time_sheet]["to_time(5i)"]}"
		params.require(:time_sheet).permit(:employees_projects_id, :project_task_id, :date_of_sheet, :from_time, :to_time)
	end
end