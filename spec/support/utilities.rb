include ApplicationHelper

RSpec::Matchers.define :have_error_message do |message|
  match do |page|
    page.should have_selector('div.alert.alert-error', text: message)
  end
end

def sign_in(user)
  visit signin_path

  fill_in 'email',    with: user.email
  fill_in 'password', with: user.password
  click_button "Sign in"

  # Sign in when not using Capybara as well.
  cookies[:remember_token] = user.remember_token
end


##
# Characters used to generate random strings
RAND_CHARS = "ABCDEFGHIJKLMNOPQRSTUVWXYZ" +
    "0123456789" +
    "abcdefghijklmnopqrstuvwxyz"


def random_string(length)
  chars = RAND_CHARS
  (1..length).map { chars[rand(chars.length)]  }.join
end