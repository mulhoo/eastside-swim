FactoryBot.define do
  factory :user do
    association :organization
    first_name { "John" }
    last_name { "Doe" }
    email { Faker::Internet.email }
    role { 0 }
    active { true }
    password_digest { BCrypt::Password.create('password123') }
  end
end
