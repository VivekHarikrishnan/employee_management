require 'spec_helper'

describe TimeSheet do
  before do
  	@employee = FactoryGirl.create(:employee, :type => "FullTimeEmployee")
  	@project = FactoryGirl.create(:project, :name => "Prj1", :client => "Client1", :type => "FullTimeProject")
  	@project_task = FactoryGirl.create(:project_task, :name => "Task1")
  	@employees_project = FactoryGirl.create(:employees_project, :employee_id => @employee.id, :project_id => @project.id)
  	@time_sheet = FactoryGirl.create(:time_sheet, :employees_projects_id => @employees_project.id, :project_task_id => @project_task.id)
  end

  subject { @time_sheet }

  it { should respond_to(:employees_projects) }
  it { should respond_to(:employee) }
  it { should respond_to(:project) }
  it { should respond_to(:project_task) }

  it { expect(@time_sheet.total_hours).to eq("1 hour(s)")  }
  it { expect(@time_sheet.total_seconds).to eq(3600.0)  }
  it { expect(@time_sheet.employee.id).to eq(@employee.id)  }
  it { expect(@time_sheet.project.id).to eq(@project.id)  }

  describe "#Valilidations" do
  	describe "#invalid" do
  		context "when project_task is not present" do
  			before { @time_sheet.project_task_id = "" }
  			it {should_not be_valid}
  		end

  		context "when employees_projects is not present" do
  			before { @time_sheet.employees_projects_id = "" } 
  			it {should_not be_valid}
  		end

  		describe "when from time and to time are not proper" do
  			context "from time greater than to time" do
  				before do
  					@time_sheet.from_time = "11:00"
  					@time_sheet.to_time = "10:00"
  				end
  				it {should_not be_valid}
  			end

			context "uniquness of date, from_time, to_time with employee and projects" do
  				it "" do
  					@time_sheet2 = FactoryGirl.build(:time_sheet, :employees_projects_id => @employees_project.id, :project_task_id => @project_task.id)
  					@time_sheet2.should_not be_valid
  				end
  			end

  			context "time entry is greater than max hours" do
  				it "" do
  					@time_sheet2 = FactoryGirl.build(:time_sheet, :employees_projects_id => @employees_project.id, :project_task_id => @project_task.id, :from_time => "09:00", :to_time => "21:00")
  					@time_sheet2.save
  					@time_sheet2.errors.full_messages.should include("To time must be less than maximum working hours 9")
  					@time_sheet2.errors.full_messages.should include("To time must be less than maximum working hours 9. Already entered for 1.0 hours. Current entry is 12.0 hours")
  					@time_sheet2.should_not be_valid
  				end
  			end
  		end
  	end

  	context "#valid" do
  	end
  end
end