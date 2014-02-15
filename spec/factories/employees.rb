# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :employee do
    sequence(:code) { |n| "EMPCODE#{n}" }
    sequence(:name) { |n| "Employee#{n}" }    
    designation "Techical Architect"
    degree "B.E"
    university "Anna University"
    college "Government College of Technology"
    city "Coimbatore"
    experience "3.7"
    address "DoorNo:2.0, Rails4.0 Street, Employee Management App, Private App- 200400"
    password "password"
    password_confirmation "password"
  end
end
