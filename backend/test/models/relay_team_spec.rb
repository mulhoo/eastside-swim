require 'rails_helper'

RSpec.describe RelayTeam, type: :model do
  describe "associations" do
    it { should belong_to(:event) }
    it { should have_many(:relay_team_athletes).dependent(:destroy) }
    it { should have_many(:athletes).through(:relay_team_athletes) }
  end

  describe "validations" do
    it { should validate_presence_of(:team_name) }
    it { should validate_presence_of(:event_id) }
  end

  describe "scopes" do
    it "returns completed and upcoming relay teams" do
      event = create(:event)
      completed_team = create(:relay_team, event: event, completed: true)
      upcoming_team = create(:relay_team, event: event, completed: false)

      expect(RelayTeam.completed).to include(completed_team)
      expect(RelayTeam.upcoming).to include(upcoming_team)
    end
  end

  describe "instance methods" do
    it "returns full team name" do
      team = build(:relay_team, team_color: "White", team_name: "Boys 400 Medley Relay")
      expect(team.full_team_name).to eq("White Boys 400 Medley Relay")
    end
  end
end
