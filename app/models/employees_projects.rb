class EmployeesProjects < ActiveRecord::Base
	validates :employee_id, :uniqueness => {:scope => [:project_id]}

	belongs_to :employee
	belongs_to :project

	has_many :time_sheets
end
