require 'rails_helper'

RSpec.describe Sport, type: :model do
  describe "associations" do
    it { should have_many(:organizations) }
    it { should have_many(:events) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name).case_insensitive }
    it { should validate_presence_of(:category) }
  end

  describe "scopes" do
    let!(:active_sport) { create(:sport, active: true) }
    let!(:inactive_sport) { create(:sport, active: false) }

    it "returns active sports" do
      expect(Sport.active).to include(active_sport)
      expect(Sport.active).not_to include(inactive_sport)
    end

    it "returns inactive sports" do
      expect(Sport.inactive).to include(inactive_sport)
      expect(Sport.inactive).not_to include(active_sport)
    end
  end
end
