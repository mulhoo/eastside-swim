FactoryBot.define do
  factory :relay_team do
    association :event
    team_name { "Boys 200 Medley Relay" }
    heat_number { 2 }
    lane_number { 5 }
    team_color { "White" }
    result_time { "1:32.45" }
    placement { 1 }
    completed { false }
  end
end
