require 'rails_helper'

RSpec.describe PracticeTime, type: :model do
  describe "associations" do
    it { should belong_to(:organization) }
    it { should belong_to(:practice_group) }
  end

  describe "validations" do
    it { should validate_presence_of(:day_of_week) }
    it { should validate_presence_of(:start_time) }
    it { should validate_presence_of(:end_time) }
    it { should validate_presence_of(:location_name) }
    it { should validate_presence_of(:location_address) }
    it { should validate_presence_of(:location_city) }
    it { should validate_presence_of(:location_state) }
    it { should validate_presence_of(:location_zip) }
    it { should validate_presence_of(:location_country) }
  end

  describe "enums" do
    it "defines days of the week" do
      expect(PracticeTime.day_of_weeks.keys).to include(
        "sunday", "monday", "tuesday", "wednesday", "thursday", "friday", "saturday"
      )
    end
  end

  describe "instance methods" do
    it "returns the correct time range" do
      practice_time = build(:practice_time, start_time: "16:00", end_time: "17:30")
      expect(practice_time.time_range).to eq("04:00 PM - 05:30 PM")
    end
  end
end
