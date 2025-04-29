require 'rails_helper'

RSpec.describe Tryout, type: :model do
  describe "associations" do
    it { should belong_to(:organization) }
    it { should belong_to(:facility).optional }
  end

  describe "validations" do
    it { should validate_presence_of(:start_date) }
    it { should validate_presence_of(:form_structure) }
  end

  describe "scopes" do
    let!(:active_tryout) { create(:tryout, active: true, start_date: Date.today + 5) }
    let!(:inactive_tryout) { create(:tryout, active: false, start_date: Date.today + 5) }
    let!(:past_tryout) { create(:tryout, start_date: Date.today - 5) }

    it "returns active tryouts" do
      expect(Tryout.active).to include(active_tryout)
      expect(Tryout.active).not_to include(inactive_tryout)
    end

    it "returns upcoming tryouts" do
      expect(Tryout.upcoming).to include(active_tryout)
      expect(Tryout.upcoming).not_to include(past_tryout)
    end

    it "returns past tryouts" do
      expect(Tryout.past).to include(past_tryout)
      expect(Tryout.past).not_to include(active_tryout)
    end
  end

  describe "instance methods" do
    it "returns true if tryout is currently open" do
      tryout = create(:tryout, active: true, start_date: Date.today - 1, end_date: Date.today + 1)
      expect(tryout.currently_open?).to be true
    end

    it "returns false if tryout is not active" do
      tryout = create(:tryout, active: false, start_date: Date.today - 1, end_date: Date.today + 1)
      expect(tryout.currently_open?).to be false
    end

    it "returns false if tryout is outside date range" do
      tryout = create(:tryout, active: true, start_date: Date.today - 10, end_date: Date.today - 5)
      expect(tryout.currently_open?).to be false
    end
  end
end
