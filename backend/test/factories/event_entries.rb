FactoryBot.define do
  factory :event_entry do
    association :event
    association :athlete
    competition_name { "100m Freestyle" }
    completed { false }
    heat_number { 1 }
    lane_number { 4 }
    team_color { "White" }
    result_time { "1:02.45" }
    placement { nil }
    personal_best { false }
    notes { nil }
  end
end
