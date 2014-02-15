class Employee < ActiveRecord::Base
	has_secure_password

	validates :code, :presence => true, :uniqueness => true
	validates :name, :presence => true
	validates :designation, :presence => true
	validates :degree, :presence => true
end
