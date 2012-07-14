require 'spec_helper'

describe UsersController do

  before :each do
    @user = Factory(:user)
  end

  describe "GET 'show'" do
    it "returns http success" do
      get 'show', :id => @user
      assigns(:user).should == @user
      response.should be_success
    end
  end

  describe "Get 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end

    it "should have the right title" do
      get 'new'
      response.should have_selector("title", :content => "Sign Up")
    end
  end
end
