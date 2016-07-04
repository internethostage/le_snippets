FactoryGirl.define do
  factory :user do
    first_name            { Faker::Name.first_name }
    last_name             { Faker::Name.last_name }
    sequence(:email)      { |n| Faker::Internet.free_email.gsub("@", "-#{n}@") }
    password              { "P4SSw0rd" }
    password_confirmation { "P4SSw0rd" }
  end
end
