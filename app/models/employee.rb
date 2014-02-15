class Employee < ActiveRecord::Base
	has_secure_password

	validates :code, :presence => true, :uniqueness => true
	validates :name, :presence => true
	validates :designation, :presence => true
	
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

	def is?(emp_type)
		self.type == emp_type.to_s
	end

	def qualification
		"#{degree_to_s}, #{university}, #{college}, #{city}"
	end

	def degree_to_s
		DEGREES.to_a[DEGREES.values.index(degree)].first
	end

	def type_to_s
		DEGREES.to_a[DEGREES.values.index(degree)].first
	end

	def experience_to_s
		yr, mo = experience.to_s.split(".")
		"#{yr} year(s) #{mo} month(s)"
	end

	def update_neccessary_fields
		last_emp = Employee.last
		cur_code_id = last_emp.code.sub("EMP", "").to_i + 1
		self.code = "EMP#{"%04d" % cur_code_id}"
		self.password = "password"
		self.password_confirmation = "password"
	end
end
