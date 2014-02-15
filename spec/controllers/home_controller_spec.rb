require 'spec_helper'

describe HomeController do
	before do
    	@employee = FactoryGirl.create(:employee, :type => "FullTimeEmployee")
    	session[:employee_session_token] = @employee.id
	end

	it "sucessfully renders index page" do
		get :index
		expect(response).to render_template("index")
	end
end