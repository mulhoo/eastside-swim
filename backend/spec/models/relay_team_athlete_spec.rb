require 'rails_helper'

RSpec.describe RelayTeamAthlete, type: :model do
  describe "associations" do
    it { should belong_to(:relay_team) }
    it { should belong_to(:athlete) }
  end

  describe "validations" do
    it { should validate_presence_of(:order) }
    it { should validate_numericality_of(:order).only_integer.is_greater_than(0) }
    it { should validate_uniqueness_of(:order).scoped_to(:relay_team_id) }
  end

  describe "scopes" do
    it "returns athletes ordered by relay leg" do
      relay_team = create(:relay_team)
      athlete1 = create(:athlete)
      athlete2 = create(:athlete)
      leg1 = create(:relay_team_athlete, relay_team: relay_team, athlete: athlete1, order: 1)
      leg2 = create(:relay_team_athlete, relay_team: relay_team, athlete: athlete2, order: 2)

      expect(relay_team.relay_team_athletes.ordered).to eq([leg1, leg2])
    end
  end

  describe "instance methods" do
    it "returns correct leg name" do
      athlete_leg = build(:relay_team_athlete, order: 1)
      expect(athlete_leg.leg_name).to eq("First Leg")
    end
  end
end
