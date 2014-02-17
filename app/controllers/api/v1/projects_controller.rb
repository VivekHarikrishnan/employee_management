module Api
  module V1
    class ProjectsController < ApplicationController
      respond_to :json

	   def index
	   	 selected_fields = Project.attribute_names - ["id", "created_at", "updated_at", "is_deleted"]
	     respond_with Project.all, :only => selected_fields 
	   end
    end
  end
end