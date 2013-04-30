require 'spec_helper'

describe Micropost do
  let(:user) { FactoryGirl.create(:user)}

  subject { user.microposts.build(content: "Lorem ipsum") }

  it { should respond_to(:content)}
  it { should respond_to(:user)}
  its(:user) { should == user}

  it { should be_valid  }


  describe "accessible attributes" do
    it "should not allow access to user_id" do
      expect {Micropost.new(user_id: user.id, content: "Test me now")}.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end

  describe "" do



  end



end
