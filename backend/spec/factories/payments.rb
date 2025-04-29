FactoryBot.define do
  factory :payment do
    association :organization
    association :athlete
    association :user

    payment_type { "registration_fee" }
    amount { 100.00 }
    due_date { Date.today + 30.days }
    paid_date { nil }
    paid { false }
    payment_method { "credit_card" }
    notes { "Payment for registration fee." }

    trait :paid do
      paid { true }
      paid_date { Date.today }
    end
  end
end
