require 'rails_helper'

RSpec.describe Event, type: :model do
  describe "associations" do
    it { should belong_to(:organization) }
    it { should have_many(:event_entries).dependent(:destroy) }
    it { should have_many(:relay_teams).dependent(:destroy) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:sport) }
    it { should validate_presence_of(:start_time) }
    it { should validate_presence_of(:end_time) }

    it "validates format of organization_registration_url" do
      should allow_value("https://example.com").for(:organization_registration_url)
      should allow_value(nil).for(:organization_registration_url)
      should_not allow_value("not_a_valid_url").for(:organization_registration_url)
    end
  end

  describe "enums" do
    it "defines status enum" do
      expect(Event.statuses.keys).to include("upcoming", "ongoing", "completed", "canceled")
    end
  end

  describe "scopes" do
    let!(:public_event) { create(:event, is_public: true) }
    let!(:private_event) { create(:event, is_public: false) }
    let!(:upcoming_event) { create(:event, status: :upcoming, start_time: 5.days.from_now, end_time: 6.days.from_now) }
    let!(:completed_event) { create(:event, status: :completed, start_time: 5.days.ago, end_time: 4.days.ago) }

    it "returns public events" do
      expect(Event.public_events).to include(public_event)
      expect(Event.public_events).not_to include(private_event)
    end

    it "returns private events" do
      expect(Event.private_events).to include(private_event)
      expect(Event.private_events).not_to include(public_event)
    end

    it "returns upcoming events ordered by start time" do
      expect(Event.upcoming_events).to include(upcoming_event)
    end

    it "returns completed events ordered by end time" do
      expect(Event.completed_events).to include(completed_event)
    end
  end

  describe "instance methods" do
    it "returns true if the event is active now" do
      event = create(:event, start_time: 1.hour.ago, end_time: 1.hour.from_now)
      expect(event.active_now?).to be true
    end

    it "returns false if the event is not active now" do
      event = create(:event, start_time: 2.days.from_now, end_time: 3.days.from_now)
      expect(event.active_now?).to be false
    end
  end
end
