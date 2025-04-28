FactoryBot.define do
  factory :practice_time do
    association :organization
    association :group
    day_of_week { :monday }
    start_time { "16:00" }
    end_time { "17:30" }
    location_name { "Main Pool" }
    location_address { "123 Swim St" }
    location_city { "Seattle" }
    location_state { "WA" }
    location_zip { "98101" }
    location_country { "USA" }
    note { "Bring fins and paddles" }
  end
end
