require 'spec_helper'

describe "Home" do
  describe "GET /" do
    it "renders login page" do
      get root_path
      expect(response.status).to be(200)
    end
  end
end