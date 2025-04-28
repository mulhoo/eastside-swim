FactoryBot.define do
  factory :practice_group do
    association :organization
    name { "Gold Team" }
    description { "Advanced swimmers" }
    practice_days { ["Monday", "Wednesday", "Friday"] }
    age_min { 10 }
    age_max { 14 }
  end
end
