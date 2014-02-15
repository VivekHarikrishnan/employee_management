# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :employees_project, :class => 'EmployeesProjects' do
    employee_id 1
    project_id 1
  end
end
