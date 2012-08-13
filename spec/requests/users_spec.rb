require 'spec_helper'

describe "Users" do
  describe "GET /users" do
    it "should not make a new user with empty form" do
      lambda do
        visit signup_path
        fill_in "user_name", :with => ""
        fill_in "Email", :with => ""
        fill_in "Password", :with => ""
        fill_in "Password Confirmation", :with => ""
        click_button
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


end
