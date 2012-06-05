require 'spec_helper'

describe "LayoutLinks" do
  routing_2_title_map = {
      '/' => 'Home',
      '/contact' => 'Contact',
      '/about' => 'About',
      '/help' => 'Help',
      '/signup' => 'Sign up'
  }

  describe "GET links" do

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


end
