require 'spec_helper'

describe "ProjectTasks" do
  describe "GET /project_tasks" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get project_tasks_path
      expect(response.status).to be(200)
    end
  end
end
