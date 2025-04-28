require 'rails_helper'

RSpec.describe Athlete, type: :model do
  describe "associations" do
    it { should belong_to(:organization) }
    it { should belong_to(:practice_group).optional }
    it { should have_many(:event_entries).dependent(:destroy) }
    it { should have_many(:relay_team_athletes).dependent(:destroy) }
    it { should have_many(:relay_teams).through(:relay_team_athletes) }
    it { should have_many(:payments).dependent(:nullify) }
  end

  describe "validations" do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
  end

  describe "scopes" do
    let!(:active_athlete) { create(:athlete, active: true) }
    let!(:inactive_athlete) { create(:athlete, active: false) }
    let!(:birthday_athlete) { create(:athlete, date_of_birth: Date.today - 20.years) }
    let!(:assigned_athlete) { create(:athlete, practice_group: create(:practice_group)) }
    let!(:unassigned_athlete) { create(:athlete, practice_group: nil) }

    it "returns active athletes" do
      expect(Athlete.active).to include(active_athlete)
      expect(Athlete.active).not_to include(inactive_athlete)
    end

    it "returns inactive athletes" do
      expect(Athlete.inactive).to include(inactive_athlete)
      expect(Athlete.inactive).not_to include(active_athlete)
    end

    it "returns athletes with birthdays this month" do
      expect(Athlete.birthday_this_month).to include(birthday_athlete)
    end

    it "returns assigned athletes" do
      expect(Athlete.assigned).to include(assigned_athlete)
      expect(Athlete.assigned).not_to include(unassigned_athlete)
    end

    it "returns unassigned athletes" do
      expect(Athlete.unassigned).to include(unassigned_athlete)
      expect(Athlete.unassigned).not_to include(assigned_athlete)
    end
  end

  describe "instance methods" do
    it "calculates correct age" do
      athlete = build(:athlete, date_of_birth: Date.today - 20.years)
      expect(athlete.age).to eq(20)
    end

    it "returns full name correctly" do
      athlete = build(:athlete, first_name: "Bobby", last_name: "Swimmer")
      expect(athlete.full_name).to eq("Bobby Swimmer")
    end
  end

  describe "callbacks" do
    it "strips whitespace from attributes before validation" do
      athlete = build(:athlete, first_name: "  Bobby ", last_name: " Swimmer  ")
      athlete.valid?
      expect(athlete.first_name).to eq("Bobby")
      expect(athlete.last_name).to eq("Swimmer")
    end
  end
end
