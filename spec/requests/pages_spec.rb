require 'spec_helper'

describe "Pages", type: :feature do
  context "Home page" do
    before(:each) { visit '/pages/home' }
    subject { page }

    it { should have_content('Sample App') }

    # bug reference: https://github.com/jnicklas/capybara/issues/844

    it { should have_selector('title', text: "| Home") }
  end

  context "Help page" do
    before(:each) { visit '/pages/help' }
    subject { page }

    it { should have_content('Help') }
    it { should have_selector('title', text: "| Help") }
  end

  context "About page" do
    before(:each) { visit '/pages/about' }
    subject { page }
    it { should have_content('About Us') }
    it { should have_selector('title', text: "| About") }
  end
end