module Api
  module V1
    class EmployeesController < ApplicationController
      respond_to :json

	   def index
	   	 selected_fields = Employee.attribute_names - ["id", "password_digest", "created_at", "updated_at", "is_deleted"]
	     respond_with Employee.where("type != 'Admin'"), :only => selected_fields
	   end
    end
  end
end