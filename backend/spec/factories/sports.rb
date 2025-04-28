FactoryBot.define do
  factory :sport do
    sequence(:name) { |n| "Sport#{n}" }
    category { "Team Sports" }
    seasonality { "Year-round" }
    individual_or_team { "individual" }
    governing_body { "Example Governing Body" }
    official_website { "https://example.com" }
    description { "A very exciting sport." }
    rules_url { "https://example.com/rules" }
    equipment_needed { "Ball, Shoes" }
    icon_url { "https://example.com/icon.png" }
    active { true }
  end
end
