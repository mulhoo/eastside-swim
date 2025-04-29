FactoryBot.define do
  factory :tryout do
    association :organization
    association :facility

    name { "Spring Tryout" }
    description { "This is a tryout for new athletes." }
    start_date { Date.today + 30 }
    end_date { Date.today + 32 }
    active { true }

    form_structure {
      {
        fields: [
          { label: "First Name", field_type: "text", required: true },
          { label: "Last Name", field_type: "text", required: true },
          { label: "Date of Birth", field_type: "date", required: true },
          { label: "Previous Experience", field_type: "select", options: ["None", "1-2 Years", "3+ Years"], required: false }
        ]
      }
    }
  end
end
