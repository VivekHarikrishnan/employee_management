require 'spec_helper'

describe "project_tasks/new" do
  before(:each) do
    assign(:project_task, stub_model(ProjectTask,
      :name => "MyString"
    ).as_new_record)
  end

  it "renders new project_task form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", project_tasks_path, "post" do
      assert_select "input#project_task_name[name=?]", "project_task[name]"
    end
  end
end
