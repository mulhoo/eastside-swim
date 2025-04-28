FactoryBot.define do
  factory :organization do
    association :sport

    sequence(:name) { |n| "Organization#{n}" }
    address { "123 Main Street" }
    city { "Seattle" }
    state { "WA" }
    zip { "98101" }
    country { "USA" }
    phone { "123-456-7890" }
    sequence(:domain_name) { |n| "organization#{n}.com" }
    website_link { "https://www.example.com" }
    description { "A great organization." }
    founded_year { "1995" }
    logo { "https://www.example.com/logo.png" }
    certifications { ["USA Swimming"] }
    national_governing_body { "USA Swimming" }
    regional_governing_body { "Pacific Northwest Swimming" }
    status { :active }
    organization_type { :club }
  end
end
