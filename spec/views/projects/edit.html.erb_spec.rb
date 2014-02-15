require 'spec_helper'

describe "projects/edit" do
  before(:each) do
    @project = assign(:project, stub_model(Project,
      :name => "Proejct1",
      :client => "Client1",
      :type => "PartTimeProject"
    ))
  end

  it "renders the edit project form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", project_path(@project), "post" do
      assert_select "input#project_name[name=?]", "project[name]"
      assert_select "input#project_client[name=?]", "project[client]"
      assert_select "select#project_type[name=?]", "project[type]"
    end
  end
end
