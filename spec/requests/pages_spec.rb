require 'spec_helper'

describe "Pages", type: :feature do
  subject { page }  # page is a singleton session

  shared_examples "a common page" do |page_heading, page_title|
      it { should have_selector('h1', text: page_heading) }
      it { should have_selector('title', text: full_title(page_title)) }
  end


  context "Home page" do
    before(:each) { visit home_path }

    it_should_behave_like "a common page", 'Sample App', ''

    it { should_not have_selector('title', text: "| Home") }
  end

  context "Help page" do
    before(:each) { visit help_path }

    it_should_behave_like "a common page", 'Help', 'Help'
  end

  context "About page" do
    before(:each) { visit about_path }

    it_should_behave_like "a common page", 'About Us', 'About'
  end

  context "Contact page" do
    before(:each) { visit contact_path }

    it_should_behave_like "a common page", 'Contact Us', 'Contact'
  end

  context "Sign up page" do
    before(:each) { visit signup_path }

    it_should_behave_like "a common page", 'Sign up', 'Sign up'
  end
end