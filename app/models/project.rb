class Project < ActiveRecord::Base
	validates :name, :presence => true, :uniqueness => {:scope => [:client]}
	validates :client, :presence => true
	TYPES = {
		"Full Time Project" => "FullTimeProject",
		"Part Time Project" => "PartTimeProject"
	}
end
