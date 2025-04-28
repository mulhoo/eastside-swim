FactoryBot.define do
  factory :facility do
    association :organization

    sequence(:name) { |n| "Facility #{n}" }
    address { "123 Main St" }
    city { "Seattle" }
    state { "WA" }
    zip { "98101" }
    country { "USA" }
    phone { "123-456-7890" }
    website { "https://www.examplefacility.com" }
    description { "An awesome facility." }
    active { true }
    facility_type { :pool }
  end
end
