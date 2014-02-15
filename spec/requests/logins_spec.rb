require 'spec_helper'

describe "Login Page" do
  subject { page }  
  describe "has input elements to login" do
  	before { visit root_path }
  	it { should have_xpath("//input[@type='text'][@name='sessions[employee_code]']") }
  	it { should have_xpath("//input[@type='password'][@name='sessions[password]']") }
  	it { should have_xpath("//select[@id='sessions_employee_type'][@name='sessions[employee_type]']") }
  	it { should have_xpath("//input[@type='submit'][@name='commit'][@value='Login']") }
  end
end
