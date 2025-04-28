require 'rails_helper'

RSpec.describe Payment, type: :model do
  describe "associations" do
    it { should belong_to(:organization) }
    it { should belong_to(:athlete).optional }
    it { should belong_to(:user).optional }
  end

  describe "validations" do
    it { should validate_presence_of(:payment_type) }
    it { should validate_presence_of(:amount) }
    it { should validate_numericality_of(:amount).is_greater_than_or_equal_to(0) }
    it { should validate_presence_of(:due_date) }
    it { should allow_value(true).for(:paid) }
    it { should allow_value(false).for(:paid) }
  end

  describe "enums" do
    it "defines payment types" do
      expect(Payment.payment_types.keys).to include("athlete_dues", "coach_payment", "pool_rental", "meet_entry_fee", "merchandise", "other")
    end
  end

  describe "scopes" do
    let!(:paid_payment) { create(:payment, paid: true) }
    let!(:unpaid_payment) { create(:payment, paid: false) }

    it "returns paid payments" do
      expect(Payment.paid).to include(paid_payment)
      expect(Payment.paid).not_to include(unpaid_payment)
    end

    it "returns unpaid payments" do
      expect(Payment.unpaid).to include(unpaid_payment)
      expect(Payment.unpaid).not_to include(paid_payment)
    end
  end

  describe "instance methods" do
    it "returns correct status" do
      payment = build(:payment, paid: true)
      expect(payment.status).to eq("Paid")
    end
  end
end
