require 'spec_helper'

describe "User pages" do
  subject {page}

  describe "signup" do
    before { visit signup_path }

    it "should not make a new user with empty form" do
      lambda do
        visit signup_path
        fill_in "user_name", :with => ""
        fill_in "Email", :with => ""
        fill_in "Password", :with => ""
        fill_in "Password Confirmation", :with => ""
        expect {click_button "Create" }.not_to change(User, :count)

        response.should render_template 'users/new'
        response.should have_selector 'div#error_explanation'
      end.should_not change(User, :count)
    end

    it "should make a new user" do
      lambda do
        visit signup_path
        fill_in "user_name", with: "testtest"
        fill_in "user_email", with: "test@test.com"
        fill_in "user_password", with: "testtest"
        fill_in "user_password_confirmation", with: "testtest"
        click_button
        response.should render_template 'users/show'
        response.should_not have_selector 'div#error_explanation'
      end.should change(User, :count).by(1)
    end
  end


  describe 'sign in/out' do
    context "when failed" do
      it "should not sign a user in " do
        visit signin_path
        fill_in :email, :with => ""
        fill_in :password, :with => ""
        click_button
        response.should have_selector("div.flash.error")

      end
    end

    context "when suceeded" do
      it "should sign a user in and out" do
        user = FactoryGirl.create(:user)
        visit signin_path
        fill_in :email, :with => user.email
        fill_in :password, :with => user.password
        click_button
        controller.should be_signed_in
        click_link "Sign out"
        controller.should_not be_signed_in
      end
    end
  end
end
