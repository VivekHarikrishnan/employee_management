class Employee < ActiveRecord::Base
	default_scope :conditions => ["is_deleted = ?", "false"]
	has_secure_password
	
	has_and_belongs_to_many :projects
	has_many :employees_projects, :class_name => "EmployeesProjects"
	has_many :time_sheets, -> { where(["time_sheets.date_of_sheet = ?", Date.today]) }, :through => :employees_projects

	validates :code, :presence => true, :uniqueness => true
	validates :name, :presence => true
	validates :designation, :presence => true

	validates :password, :length => {:minimum => 6}
	validates :password_confirmation, :length => {:minimum => 6}
	
	# before_create :update_neccessary_fields

	TYPES = {
		"Full Time Employee" => "FullTimeEmployee",
		"Part Time Employee" => "PartTimeEmployee",
		"Admin" => "Admin"
	}

	DEGREES = {
		"B.E/B.Tech" => "be",
		"M.E/M.Tech" => "me",
		"B.Sc" => "bsc",
		"MSc" => "msc",
		"BCA" => "bca",
		"MCA" => "mca",
		"MBA" => "mba"
	}

	def all_time_sheets
		employees_projects.map(&:time_sheets).flatten
	end

	def self.valid_employees
		where("type != 'Admin'")
	end

	def is?(emp_type)
		self.type == emp_type.to_s
	end

	def qualification
		"#{degree_to_s}, #{university}, #{college}, #{city}"
	end

	def degree_to_s
		DEGREES.values.index(degree) ? DEGREES.to_a[DEGREES.values.index(degree)].first : ""
	end

	def type_to_s
		TYPES.values.index(type) ? TYPES.to_a[TYPES.values.index(type)].first : ""
	end

	def experience_to_s
		yr, mo = experience.to_s.split(".")
		"#{yr} year(s) #{mo} month(s)"
	end

	def update_neccessary_fields
		last_emp = Employee.last
		cur_code_id = last_emp ? (last_emp.code.sub("EMP", "").to_i + 1) : "EMP0001"
		self.code = "EMP#{"%04d" % cur_code_id}"
		self.password = "password"
		self.password_confirmation = "password"
	end
end
