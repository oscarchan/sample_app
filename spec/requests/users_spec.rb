require 'spec_helper'

describe "User pages" do
  subject {page}

  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user)
    }

    it { should have_selector('h1', text: user.name) }
    it { should have_selector("title", text: user.name) }
  end

  describe "signup" do
    before { visit signup_path }

    context "when form is empty" do
      it "should not make a new user" do
        expect { click_button "Create" }.not_to change(User, :count)
      end

      context "it should generate errors" do
        before (:each) { click_button "Create" }
        it { should have_selector('div#error_explanation h2', text: 'error')}
        it { should have_selector('div.field_with_errors input#user_password') }
        it { should have_selector('div.field_with_errors input#user_email') }
        it { should have_selector('div.field_with_errors input#user_password') }
        it { should have_selector('div.field_with_errors input#user_password_confirmation') }


      end

    end

    it "should make a new user" do
        fill_in "user_name", with: "testtest"
        fill_in "user_email", with: "test@test.com"
        fill_in "user_password", with: "testtest"
        fill_in "user_password_confirmation", with: "testtest"
        expect { click_button "Create"}.to change(User, :count).by(1)
    end
  end


  describe 'sign in/out' do
    context "when failed" do
      it "should not sign a user in " do
        visit signin_path
        fill_in :email, :with => ""
        fill_in :password, :with => ""
        click_button
        response.should have_selector("div.flash.error")

      end
    end

    context "when suceeded" do
      it "should sign a user in and out" do
        user = FactoryGirl.create(:user)
        visit signin_path
        fill_in :email, :with => user.email
        fill_in :password, :with => user.password
        click_button
        controller.should be_signed_in
        click_link "Sign out"
        controller.should_not be_signed_in
      end
    end
  end
end
