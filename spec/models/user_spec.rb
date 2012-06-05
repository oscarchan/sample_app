require 'spec_helper'

describe User do

  before :each do
    @attr = { :name => "Oz Cha", :email => "oz@cha.com"}
  end

  describe "name" do
    it "should have a name" do
      updated_attr = @attr.merge :name => ""

      user = User.new(updated_attr)
      user.should_not be_valid
      user.errors.should_not be_nil
      user.should have(1).error_on(:name)
    end

    it "should have name of valid size" do
      chars = ('a'..'z').to_a

      updated_attr = @attr.merge :name => (0..64).map{ |i| chars[rand(chars.length)] }.join

      user = User.new(updated_attr)
      user.should_not be_valid
      user.errors.should_not be_nil
      user.should have(1).error_on(:name)
    end
  end

  describe "email" do
    it "should have an email" do
      updated_attr = @attr.merge :email => nil

      user = User.new(updated_attr)
      user.should_not be_valid
      user.should have_at_least(1).error_on(:email)
    end

    it "should have a valid email" do
      %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp].each do |email|
        updated_attr = @attr.merge :email => email

        user = User.new(updated_attr)
        user.should be_valid
      end
    end

    it "should reject bad emails" do
      %w[user@foo,com user_at_foo.org example.user@foo.].each do |email|
        updated_attr = @attr.merge :email => email
        user = User.new(updated_attr)
        user.should_not be_valid
        user.should have(1).error_on(:email)
      end
    end

    it "should reject duplicate emails" do
      User.create!(@attr)

      user = User.new(@attr)
      user.should_not be_valid
      user.should have_at_least(1).error_on(:email)

      @attr.merge :email => @attr[:email].upcase
      user = User.new(@attr)
      user.should_not be_valid
      user.should have_at_least(1).error_on(:email)

    end
  end

end
