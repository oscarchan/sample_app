require 'spec_helper'

describe "LayoutLinks" do
  describe "GET links" do
    routing_2_title_map = {
        '/' => 'Home',
        '/contact' => 'Contact',
        '/about' => 'About',
        '/help' => 'Help',
        '/signup' => 'Sign up'
    }


    routing_2_title_map.each { |path, title|
      it "should have a #{title} page" do
        get path


        response.status.should be(200 )
        response.should have_selector('title', :content => title)
      end
    }

  end

  #describe "visit links" do
  #  visit '/'
  #  routing_2_title_map.each { |path, title|
  #    click_link title
  #  }
  #
  #
  #end

  describe "when not signed in" do
    it "should have a signin link" do
      visit root_path

      response.should have_selector("a", :href => signin_path, :content => "Sign in")
    end
  end

  describe "when signed in" do
    before :each do
      @user = FactoryGirl.create :user
      visit signin_path
      fill_in :email, :with => @user.email
      fill_in :password, :with => @user.password
      click_button
    end

    it "should have a signout link" do
      visit root_path
      response.should have_selector("a", :href => signout_path, :content => "Sign out")
    end

    it "should have a profile link" do
      visit root_path
      response.should have_selector("a", :href => user_path(@user), :content => "Profile")
    end
  end
end
