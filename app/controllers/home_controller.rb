class HomeController < ApplicationController
  before_filter :require_login
  def index
  	@employee = Employee.new
  end
end
