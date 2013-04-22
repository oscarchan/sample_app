

FactoryGirl.define do
  factory :user do |f|
    f.sequence(:email) { |n| "testuser#{n}@test.com" }
    f.sequence(:name) { |n| "Test Rob #{n}" }
    password "welcome"
    password_confirmation "welcome"

    factory :admin do |f|
      admin true
    end
  end
end