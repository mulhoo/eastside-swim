FactoryBot.define do
  factory :athlete do
    association :organization
    first_name { "Bobby" }
    last_name { "Swimmer" }
    date_of_birth { 16.years.ago }
    active { true }
  end
end
