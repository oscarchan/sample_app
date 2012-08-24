

FactoryGirl.define do
  factory :user do |f|
    f.sequence(:email) { |n|
      puts "email=testuser#{n}@test.com"
      "testuser#{n}@test.com"
    }
    name "Oz Chan"
    password "welcome"
    password_confirmation "welcome"
  end
end