require 'spec_helper'

describe User do

  before :each do
    @user = User.new(
        name: "Oz Cha",
        email: "oz@cha.com",
        password: "foobar",
        password_confirmation: "foobar"
    )
  end

  subject { @user }

  it { should be_valid }

  def random_string(length)
    chars = ('a'..'z').to_a
    (1..length).map { chars[rand(chars.length)]  }.join
  end

=begin
  describe "authentication" do
    before :each do
      @user.save
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
=end

  context "name" do
    describe "should be present" do
      before(:each) { @user.name = "" }

      it { should_not be_valid }
      its(:errors)  { should_not be_nil }
      it { should have_at_least(1).error_on(:name) }
    end

    describe "should be of certain size" do
      before(:each) { @user.name = random_string(64) }

      it { should_not be_valid }
      its(:errors) { should_not be_nil }
      it { should have_at_least(1).error_on(:name) }
    end
  end

  context "email" do
    describe "should be present" do
      before(:each) { @user.email = nil }

      it { should_not be_valid }
      it { should have_at_least(1).error_on(:email) }
    end

    it "should be in valid email format" do
      %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp].each do |email|
        @user.email = email
        @user.should be_valid
      end
    end

    it "should reject invalid email format" do
      %w[user@foo,com user_at_foo.org example.user@foo.].each do |email|
        @user.email = email
        @user.should_not be_valid
        @user.should have(1).error_on(:email)
      end
    end

    describe "should reject duplicate emails" do
      before(:each) {
        dup = @user.dup
        dup.email = dup.email.upcase
        dup.save
      }

      it { should_not be_valid }
      it { should have_at_least(1).error_on(:email) }
    end

  end
end
