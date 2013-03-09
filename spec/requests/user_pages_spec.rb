require 'spec_helper'

describe "User Pages" do

  describe "profile page" do
    let(:user) { @user = FactoryGirl.create(:user) }
    before { visit user_path(user) }

    it { should have_selector('h1', text: user.name) }
    it { should have_selector("title", text: user.name) }
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
        }.should_not change(User, :count)

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

  context "form fields" do
    before :each do
      get :new
    end

    subject { response }

    it "should have a name field" do
      response.should have_selector 'input#user_name'
    end

    it { should have_selector 'input#user_email' }

    it { should have_selector 'input#user_password' }

    it { should have_selector 'input#user_password_confirmation' }


  end

  context "incomplete form" do
    before :each do
      @form_parameters = {user_name: "testtest", user_email: "test@test.com", user_password: "testtest", user_password_confirmation: "testtest" }
    end

  end

end
