require 'spec_helper'

describe HomeController do
	it "sucessfully renders index page" do
		get :index
		expect(response).to render_template("index")
	end
end