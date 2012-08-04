require 'spec_helper'
1
describe UsersController do
  render_views

  before :each do
    @user = FactoryGirl.create(:user)
  end

  describe "GET 'show'" do
    it "returns http success" do
      get 'show', :id => @user
      assigns(:user).should == @user
      response.should be_success
    end
  end

  describe "Get 'new'" do
    before :each do
      @attr = {
          name: "",
          email: "",
          password: "",
          password_confirmation: ""
      }
    end

    it "should be successful" do
      get :new
      response.should be_success
    end

    it "should have the right title" do
      get :new
      response.should have_selector("title", content: "Ruby on Rails Tutorial Sample App | Sign up")
    end

    it "should not accept an empty form" do
      get :new

      lambda {
        post :create, :user => @attr
      }.should_not change(User, :count)
    end

    it "should render the 'new' page" do
      post :create, :user => @attr
      response.should render_template('new')
    end
  end

end
