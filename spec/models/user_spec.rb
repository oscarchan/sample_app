require 'spec_helper'

describe User do

  before :each do
    @attr = {
        :name => "Oz Cha",
        :email => "oz@cha.com",
        :password => "foobar",
        :password_confirmation => "foobar"
    }
  end

  def random_string(length)
    chars = ('a'..'z').to_a
    (1..length).map { chars[rand(chars.length)]  }.join
  end

  describe "authentication" do
    before :each do
      @user = User.create!(@attr)
    end

    it "should return nil when no such user" do
      user = User.authenticate("nosuch@email.com", @attr[:password])
      user.should be_nil
    end

    it "should return nil when authentication fails" do
      user = User.authenticate(@attr[:email], "xxxxx")
      user.should be_nil
    end

    it "should return nil when authentication passes" do
      user = User.authenticate(@attr[:email], @attr[:password])
      user.should_not be_nil

      @user.id.should == user.id

    end
  end
  describe "password encryption" do
    before :each do
      @user = User.create!(@attr)
    end

    it "should set password encryption" do
      @user.encrypted_password.should_not be_blank
    end

    describe "has_password? method" do
      it "should be true if the passwords match" do
        @user.has_password?(@attr[:password]).should be_true
      end

      it "should be false if the passwords don't match'" do
        @user.has_password?("xxxxx").should be_false
      end
    end
  end
  describe "password validations" do
    it "should create a new instance given valid attribute" do
      User.create!(@attr)
    end

    it "should require a password" do
      attr = @attr.merge(:password => "", :password_confirmation => "")
      user = User.new(attr)
      user.should_not be_valid
      user.should have_at_least(1).error_on(:password)
    end

    it "should require a password matching password_confirmation " do
      attr = @attr.merge(:password_confirmation => "")
      user = User.new(attr)
      user.should_not be_valid
      user.should have_at_least(1).error_on(:password)
    end

    it "should reject long passwords" do
      password = random_string(50)
      attr = @attr.merge(:password => password, :password_confirmation => password)
      user = User.new(attr)
      user.should_not be_valid
      user.should have_at_least(1).error_on(:password)
    end

    it "should reject short passwords" do
      password = random_string(5)
      attr = @attr.merge(:password => password, :password_confirmation => password)
      user = User.new(attr)
      user.should_not be_valid
      user.should have_at_least(1).error_on(:password)
    end



  end

  describe "name" do
    it "should have a name" do
      updated_attr = @attr.merge :name => ""

      user = User.new(updated_attr)
      user.should_not be_valid
      user.errors.should_not be_nil
      user.should have_at_least(1).error_on(:name)
    end

    it "should have name of valid size" do
      chars = ('a'..'z').to_a

      updated_attr = @attr.merge :name => (0..64).map{ |i| chars[rand(chars.length)] }.join

      user = User.new(updated_attr)
      user.should_not be_valid
      user.errors.should_not be_nil
      user.should have_at_least(1).error_on(:name)
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
