require 'spec_helper'



describe "In session's" do

  subject { page }

  describe "signin page" do
    before(:each) { visit signin_path }

    it { should have_selector('h1', text: "Sign in") }
    it { should have_selector("title", :text => "Sign in")}
    it { should_not have_link('Profile')}
    it { should_not have_link('Settings')}


    context "with invalid login" do
      before (:each) { click_button "Sign in" }

      it { should have_selector('h1', text: "Sign in") }
      it { should have_selector("div.alert.alert-error", text: "Invalid email/password")}

      context "after visiting another page " do
        before { click_link "Home" }
        it { should_not have_selector("div.alert.alert-error")}
      end
    end

    context "with valid login" do
      let(:user) { FactoryGirl.create(:user) }

      before { sign_in(user) }

      it { should have_selector('title', text: user.name) }
      it { should have_link('Users', href: users_path)}
      it { should have_link('Profile', href: user_path(user))}
      it { should have_link('Settings', href: edit_user_path(user))}
      it { should have_link('Sign out', href: signout_path)}
      it { should_not have_link('Sign in', href: signin_path)}

      context "after signed out" do
        before { click_link "Sign out"}

        it { should have_link('Sign in')}
      end
    end
  end

=begin
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
=end
end
