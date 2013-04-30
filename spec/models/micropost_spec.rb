require 'spec_helper'

describe Micropost do
  let(:user) { FactoryGirl.create(:user)}

  subject(:micropost) { user.microposts.build(content: "Lorem ipsum") }

  it { should respond_to(:content)}
  it { should respond_to(:user)}
  its(:user) { should == user}

  it { should be_valid  }


  describe "accessible attributes" do
    it "should not allow access to user_id" do
      expect {Micropost.new(user_id: user.id, content: "Test me now")}.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end

  describe "should not allow long content" do
    before { micropost.content = random_string(150) }

    it { should_not be_valid }
  end

  describe "should not allow blank content" do
    before { micropost.content = ""}

    it { should_not be_valid }
  end

  describe "should not allow invalid user id" do
    before { micropost.user_id = nil}

    it { should_not be_valid }
  end

end
