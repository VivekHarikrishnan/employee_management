class EmployeesProjects < ActiveRecord::Base
	validates :employee_id, :uniqueness => {:scope => [:project_id]}
end
