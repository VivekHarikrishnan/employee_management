require 'spec_helper'

describe ProjectTask do
  subject { @project_task = FactoryGirl.create(:project_task) }

  it { should respond_to(:name) }
end
