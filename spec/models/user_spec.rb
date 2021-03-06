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
  it { should respond_to(:name)}
  it { should respond_to(:email)}
  it { should respond_to(:password)}
  it { should respond_to(:password_confirmation)}
  it { should respond_to(:password_digest)}
  it { should respond_to(:authenticate)}
  it { should respond_to(:remember_token)}
  it { should respond_to(:admin)}

  it "should not allow mass assignment on admin field" do
    expect {
      User.new(
          name: "Oz Cha",
          email: "oz@cha.com",
          password: "foobar",
          password_confirmation: "foobar",
          admin: true
      )
    }.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
  end

  def random_string(length)
    chars = ('a'..'z').to_a
    (1..length).map { chars[rand(chars.length)]  }.join
  end

  describe "authentication" do
    before { @user.save }

    context "with valid password" do
      it { should == User.authenticate(@user.email, @user.password) }
    end

    context "with invalid password" do
       it { User.authenticate(@user.email, "xxxxx").should be_false }
    end

    context "with invalid email" do
      it { User.authenticate("xxxxx", @user.password).should be_false }
    end
  end

  describe "remember token" do
    before { @user.save }
    its(:remember_token) { should_not be_blank}
  end
  describe "password encryption" do
    before { @user.save }

    its(:password_digest) { should_not be_blank }
  end

  describe "password validations" do
    context "should create a new instance given valid attribute" do
      it { should be_valid }
    end

    context "should require a password" do
      before(:each) { @user.password =  @user.password_confirmation = "" }

      it { should_not be_valid }
      it { should have_at_least(1).error_on(:password) }
    end


    context "should require a password matching password_confirmation " do
      before (:each) { @user.password_confirmation = "" }

      it {should_not be_valid }
      it {should have_at_least(1).error_on(:password) }
    end

    context "should reject long passwords" do
      before(:each) { @user.password = @user.password_confirmation = random_string(50) }
      it { should_not be_valid }
      it {should have_at_least(1).error_on(:password) }
    end

    context "should reject short passwords" do
      before(:each) { @user.password = @user.password_confirmation = random_string(5) }
      it { should_not be_valid }
      it {should have_at_least(1).error_on(:password) }
    end



  end

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
