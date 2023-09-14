FactoryBot.define do
  factory :adventure do
    name { Faker::Lorem.word } # Use Faker to generate a random name
  end
end
