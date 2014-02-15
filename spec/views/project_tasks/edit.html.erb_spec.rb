require 'spec_helper'

describe "project_tasks/edit" do
  before(:each) do
    @project_task = assign(:project_task, stub_model(ProjectTask,
      :name => "MyString"
    ))
  end

  it "renders the edit project_task form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", project_task_path(@project_task), "post" do
      assert_select "input#project_task_name[name=?]", "project_task[name]"
    end
  end
end
