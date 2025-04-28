FactoryBot.define do
  factory :event do
    association :organization
    name { "Pacific Northwest Swim Championship" }
    sport { "Swimming" }
    start_time { 1.week.from_now }
    end_time { 1.week.from_now + 2.days }
    status { :upcoming }
    location { "Seattle Aquatics Center" }
  end
end
