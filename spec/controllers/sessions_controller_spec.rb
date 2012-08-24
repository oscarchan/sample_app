require 'spec_helper'

describe SessionsController do
  render_views

  describe "GET 'new'" do
    before(:each) { get 'new' }
    subject { response }

    it { should be_success }

    it { should have_selector("title", :content => "Sign in")}
  end

  describe "POST 'create'" do
    before :each do
      attr = FactoryGirl.attributes_for(:user)
      @attr = attr.slice(:email, :password)

      @user = User.new(attr)
      @user.save!
    end

    context "when login successfully" do
      before(:each) { post :create, :session => @attr }
      it "should sign user in" do
        controller.current_user.should == @user
        controller.should be_signed_in
      end

      it "should redirect to the user show page" do
        response.should redirect_to user_path(@user)
      end
    end

    context "when login fails" do
      before :each do
        @attr = @attr.merge({ :password =>  "invalid" })
        post :create, :session => @attr
      end

      subject { response }

      it { should render_template('new') }

      it "should have a error message when login fails" do
        flash.now[:error].should =~ /invalid/i
      end
    end

  end

  describe "DELETE 'destroy'" do
    it "should do sign a user" do
      user = FactoryGirl.create(:user)
      controller.sign_in(user)

      #test_sign_in(user)
      delete :destroy

      controller.should_not be_signed_in
      controller.should redirect_to root_path
    end

  end
end
