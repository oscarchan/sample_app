require 'spec_helper'

describe "Pages", type: :feature do
  context "Home page" do
    before(:each) { visit '/pages/home' }
    subject { page }

    it { should have_selector('h1', text: "Sample App") }
    it { should have_selector('title', text: "| Home") }
  end

  context "Help page" do
    before(:each) { visit '/pages/help' }
    subject { page }

    it { should have_selector('h1', text: "Help") }
    it { should have_selector('title', text: "| Help") }
  end

  context "About page" do
    before(:each) { visit '/pages/about' }
    subject { page }
    it { should have_selector('h1', text: 'About Us') }
    it { should have_selector('title', text: "| About") }
  end

  context "Contact page" do
    before(:each) { visit '/pages/contact' }
    subject { page }

    it { should have_selector('h1', text: 'Contact Us') }
    it { should have_selector('title', text: "| Contact") }  end
end