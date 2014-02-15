require 'spec_helper'

describe "Login Page" do
  subject { page }  
  describe "has input elements to login" do
  	before { visit root_path }
  	it { should have_xpath("//input[@type='text'][@name='employee[code]']") }
  end
end
