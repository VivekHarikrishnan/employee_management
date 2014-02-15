class Project < ActiveRecord::Base
	default_scope :conditions => ["is_deleted = ?", "false"]
	has_and_belongs_to_many :employees

	validates :name, :presence => true, :uniqueness => {:scope => [:client]}
	validates :client, :presence => true
	TYPES = {
		"Full Time Project" => "FullTimeProject",
		"Part Time Project" => "PartTimeProject"
	}

	def self.valid_projects_for(emp_type)
		if emp_type == "FullTimeEmployee"
			FullTimeProject.valid_projects
		elsif emp_type == "PartTimeEmployee"
			PartTimeProject.valid_projects
		else
			[]
		end
	end

	def self.valid_projects
		all
	end
end
