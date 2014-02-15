require 'spec_helper'

describe Employee do
  before { @employee = FactoryGirl.create(:employee) }
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
  
  context "when degree is not present" do
  	before { @employee.degree = "" }
  	it {should_not be_valid}
  end
  
  context "when designation is not present" do
  	before { @employee.designation = "" }
  	it {should_not be_valid}
  end
end