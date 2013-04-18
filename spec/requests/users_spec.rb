require 'spec_helper'

describe "As for User's" do
  subject {page}

  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user)}

    it { should have_selector('h1', text: user.name) }
    it { should have_selector("title", text: user.name) }
  end

  describe "signup page" do
    before { visit signup_path }

    context "when form is empty" do
      it "should not make a new user" do
        expect { click_button "Create" }.not_to change(User, :count)
      end

      context "and submitted" do
        before (:each) { click_button "Create" }
        it { should have_selector('div#error_explanation h2', text: 'error')}
        it { should have_selector('div.field_with_errors input#user_password') }
        it { should have_selector('div.field_with_errors input#user_email') }
        it { should have_selector('div.field_with_errors input#user_password') }
        it { should have_selector('div.field_with_errors input#user_password_confirmation') }
      end
    end

    context "with valid information" do
      before {
        fill_in "user_name", with: "testtest"
        fill_in "user_email", with: "test@test.com"
        fill_in "user_password", with: "testtest"
        fill_in "user_password_confirmation", with: "testtest"
      }

      it "should make a new user" do
        expect { click_button "Create"}.to change(User, :count).by(1)
      end

      context "after saving the user" do
        before (:each) { click_button "Create"}

        it { should have_selector('title', text: "testtest") }
        it { should have_selector('div.alert.alert-success', text: 'Welcome') }
        it { should have_link('Sign out')}

      end
    end
  end


  describe 'sign in/out' do
    context "when failed" do
      it "should not sign a user in " do
        visit signin_path
        fill_in :email, :with => ""
        fill_in :password, :with => ""
        click_button "Sign in"

        page.should have_selector("div.alert.alert-error")

      end
    end

    context "when succeeded" do
        let(:user)  { FactoryGirl.create(:user) }

        before do
          visit signin_path
          valid_signin(user)
        end

        it {
          all('title')
          should have_selector('title', text: user.name)
        }

#        it { should have_link('Users',    href: users_path) }
        it { should have_link('Profile',  href: user_path(user)) }
        it { should have_link('Settings', href: edit_user_path(user)) }
        it { should have_link('Sign out', href: signout_path) }
        it { should_not have_link('Sign in', href: signin_path) }
    end
  end
end
