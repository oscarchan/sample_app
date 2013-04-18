Given(/^a user visits the signin page$/) do
  visit signin_path
end

Given /^the user has an account$/ do
  @user = User.create(name: "Example User", email: "user@example.com",
                      password: "foobar", password_confirmation: "foobar")
end


When(/^he submits invalid signin information$/) do
  click_button "Sign in"
end

Then(/^he should see an error message$/) do
  page.should have_selector('div.alert.alert-error')
end

When(/^he submits valid signin information$/) do
  fill_in "Email", with: @user.email
  fill_in "Password", with: @user.password
  click_button "Sign in"
end

Then(/^he should see his profile page$/) do
  fields = all(:css, "title").map {|node| node.native}
  logger.info("fields=#{fields}")
  page.should have_selector("title", @user.name)
end

Then(/^he should see a signout link$/) do
  page.should have_link("Sign out", href: signout_path)
end