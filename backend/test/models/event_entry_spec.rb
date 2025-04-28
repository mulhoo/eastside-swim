require 'rails_helper'

RSpec.describe EventEntry, type: :model do
  describe "associations" do
    it { should belong_to(:event) }
    it { should belong_to(:athlete) }
  end

  describe "validations" do
    it { should validate_presence_of(:competition_name) }
    it { should allow_value(true).for(:completed) }
    it { should allow_value(false).for(:completed) }
  end

  describe "scopes" do
    let!(:completed_entry) { create(:event_entry, completed: true) }
    let!(:upcoming_entry) { create(:event_entry, completed: false) }

    it "returns completed event entries" do
      expect(EventEntry.completed).to include(completed_entry)
      expect(EventEntry.completed).not_to include(upcoming_entry)
    end

    it "returns upcoming event entries" do
      expect(EventEntry.upcoming).to include(upcoming_entry)
      expect(EventEntry.upcoming).not_to include(completed_entry)
    end
  end
end
