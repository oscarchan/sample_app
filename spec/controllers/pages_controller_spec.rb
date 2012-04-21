require 'spec_helper'

describe PagesController do
  render_views

  describe "GET 'home'" do
    it "returns http success" do
      get 'home'
      response.should be_success
    end

    it "should have the title" do
      get 'home'
      response.should have_selector("title", :content => "Ruby on Rails Tutorial Sample App | Home")
    end
  end

  describe "GET 'contact'" do
    it "returns http success" do
      get 'contact'
      response.should be_success
    end
  end

  describe "Get 'about'" do
    it "returns http success" do
      get 'about'
      response.should be_success
    end

  end

  describe "Get 'help'" do
    it "returns http success" do
      get 'help'
      response.should be_success
    end

    it "returns the right title" do
      get 'help'
      response.should have_selector "title", :content => "Ruby on Rails Tutorial Sample App | Help"
    end
  end

end
