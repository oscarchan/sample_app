require 'spec_helper'

describe "Users" do
  describe "GET /users" do
    it "should not make a new user" do
      visit signup_path
      fill_in "Name", :with => ""
      fill_in "Email", :with => ""
      fill_in "Password", :with => ""
      fill_in "Confirmation", :with => ""
      click_button
      response.should render_template 'user/new'
      response.should have_selector 'div#error_explanation'

      #get users_index_path
      #response.status.should be(200)
    end
  end
end
