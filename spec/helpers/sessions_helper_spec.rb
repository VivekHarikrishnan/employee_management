require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the SessionsHelper. For example:
#
# describe SessionsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
describe SessionsHelper do
  before do
  	@employee = FactoryGirl.create(:employee, :type => "Admin")
  end

  it "stores session details" do
  	helper.save_session_details(@employee)

  	session[:employee_session_token].should eq(@employee.id) 
  end

  it "deletes sesion details" do
  	helper.save_session_details(@employee)
  	helper.destroy_session_details

  	session[:employee_session_token].should be_nil
  end
end
