require 'spec_helper'

describe "Pages", type: :feature do

  context "Home page" do
    before(:each) { visit home_path }
    subject { page }

    it { should have_selector('h1', text: "Sample App") }
    it { should have_selector('title', text: full_title('')) }
    it { should_not have_selector('title', text: "| Home") }
  end

  context "Help page" do
    before(:each) { visit help_path }
    subject { page }

    it { should have_selector('h1', text: "Help") }
    it { should have_selector('title', text: "| Help") }
  end

  context "About page" do
    before(:each) { visit about_path }
    subject { page }
    it { should have_selector('h1', text: 'About Us') }
    it { should have_selector('title', text: "| About") }
  end

  context "Contact page" do
    before(:each) { visit contact_path }
    subject { page }

    it { should have_selector('h1', text: 'Contact Us') }
    it { should have_selector('title', text: "| Contact") }
  end

  context "Sign up page" do
    before(:each) { visit signup_path }
    subject { page }
    it { should have_selector('h1', text: 'Sign up')}
    it { should have_selector('title', text: "Sign up")}
  end
end