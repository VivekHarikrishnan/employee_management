require 'spec_helper'

describe "project_tasks/index" do
  before(:each) do
    assign(:project_tasks, [
      stub_model(ProjectTask,
        :name => "Name"
      ),
      stub_model(ProjectTask,
        :name => "Name"
      )
    ])
  end

  it "renders a list of project_tasks" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
