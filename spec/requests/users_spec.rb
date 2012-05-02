require 'spec_helper'

describe "sign up users" do
  subject {page}
  
  it "signup page" do
    visit '/users#new'
    page.should have_selectore('title', text: 'sign up')
  end
  
  describe "GET /users" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get users_path
      response.status.should be(200)
    end
  end
end
