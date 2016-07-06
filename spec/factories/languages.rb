FactoryGirl.define do
  factory :language do
    name  { Faker::Hacker.abbreviation }
  end
end
