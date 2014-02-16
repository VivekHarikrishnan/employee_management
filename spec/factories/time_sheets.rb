# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :time_sheet do
    employees_projects_id 1
    project_task_id 1
    date_of_sheet "2014-02-16"
    from_time "10:00"
    to_time "11:00"
  end
end
