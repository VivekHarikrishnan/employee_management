require 'spec_helper'

describe Employee do
  before { @employee = FactoryGirl.create(:employee, :type => "Admin") }
  subject { @employee }

  it { should respond_to :code }
  it { should respond_to :name }
  it { should respond_to :designation }
  it { should respond_to :degree }
  it { should respond_to :university }
  it { should respond_to :college }
  it { should respond_to :city }
  it { should respond_to :experience }
  it { should respond_to :address }
  it { should respond_to :password }
  it { should respond_to :password_confirmation }

  it {should be_valid}

  context "when code is not present" do
  	before { @employee.code = "" }
  	it {should_not be_valid}
  end

  it "raise error when code is not unique" do
  	expect { FactoryGirl.create(:employee, :code => @employee.code) }.to raise_error(ActiveRecord::RecordInvalid, /Code has already been taken/)
  end
  
  context "when name is not present" do
  	before { @employee.name = "" }
  	it {should_not be_valid}
  end
  
  context "when designation is not present" do
  	before { @employee.designation = "" }
  	it {should_not be_valid}
  end

  describe "valid employees" do
    before do 
      @employees = [FactoryGirl.create(:employee, :type => "FullTimeEmployee"),
        FactoryGirl.create(:employee, :type => "PartTimeEmployee")]
    end

    it "returns only part time and full time employees" do
      Employee.valid_employees.collect(&:id).should == @employees.collect(&:id)
    end

    it "should not return admin employees" do
      Employee.valid_employees.should_not include(@employee)
    end

    it "is?('Admin') returns true if employee is admin" do
      @employee.is?('Admin').should == true
    end

    it "is?('Admin') returns false if employee is not an admin" do
      @employee.is?('FullTimeEmployee').should  == false
    end
  end

  describe "attr to_s methods" do
    before { @employee1 = Employee.new }

    it "qualification returns consolidated details of degree, university, college" do
      @employee1.qualification.should == ", , , "
      
      @employee1.degree = "be"
      @employee1.university = "University"
      @employee1.college = "College"
      @employee1.city = "City"

      @employee1.qualification.should == "B.E/B.Tech, University, College, City"
    end

    it "experience returns years and month details" do
      @employee1.experience_to_s.should == " year(s)  month(s)"

      @employee1.experience = 3.11

      @employee1.experience_to_s.should == "3 year(s) 11 month(s)"
    end

    it "update_neccessary_fields to have code, password fields" do
      @employee1.update_neccessary_fields
      @employee1.code.should == "EMP#{"%04d" % (@employee.code.sub("EMP", "").to_i + 1)}"
    end
  end
end