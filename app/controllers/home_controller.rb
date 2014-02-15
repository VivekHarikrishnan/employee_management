class HomeController < ApplicationController
  def index
  	@employee = Employee.new
  end
end
