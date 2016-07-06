FactoryGirl.define do
  factory :snippet do
    name      { Faker::Hacker.adjective }
    body      { Faker::Hacker.say_something_smart }
    private   { false }
    association :user, strategy: :build
    association :language, strategy: :build
  end
end
