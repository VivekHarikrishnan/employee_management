require 'spec_helper'

describe Project do
  subject { @project = FactoryGirl.create(:project) }

  it { should respond_to(:name) }
  it { should respond_to(:client) }
  it { should respond_to(:type) }
end
