require 'spec_helper'

describe EmployeesProjects do
  subject { @employees_projects = FactoryGirl.create(:employees_project) }

  it { should respond_to(:employee_id) }
  it { should respond_to(:project_id) }
end