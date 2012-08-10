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

    it "should be successful" do
      get :new
      response.should be_success
    end

    it "should have the right title" do
      get :new
      response.should have_selector("title", content: "Ruby on Rails Tutorial Sample App | Sign up")
    end
  end

  describe "POST 'create'" do
    context "success" do
      before :each do
        @attr = {
            name: "Test User",
            email: "test_user@test.com",
            password: "testpass",
            password_confirmation: "testpass"
        }
      end

      it "should create an user" do
        lambda {
          post :create, :user => @attr
        }.should change(User, :count).by(1)
      end

      it "should not create an user when password is not confirmed" do
        @attr.delete(:password_confirmation)

        lambda {
          post :create, :user => @attr
        }.should change(User, :count).by(0)

      end

      it "should redirect to the user show page" do
        post :create, :user => @attr
        response.should redirect_to(user_path(assigns(:user)))
      end

      it "should should the successful flash" do
        post :create, :user => @attr
        flash[:success].should =~ /welcome to the sample app/i
      end
    end
    context "failure" do
      before :each do
        @attr = {
            name: "",
            email: "",
            password: "",
            password_confirmation: ""
        }
      end

      it "should not accept an empty form" do
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

end
