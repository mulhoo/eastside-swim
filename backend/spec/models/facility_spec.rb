require 'rails_helper'

RSpec.describe Facility, type: :model do
  describe "associations" do
    it { should have_many(:organization_facilities) }
    it { should have_many(:organizations).through(:organization_facilities) }
    it { should have_many(:events) }
    it { should have_many(:practice_times) }
    it { should have_many(:tryouts) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:address) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:zip) }
    it { should validate_presence_of(:country) }
    it { should validate_presence_of(:facility_type) }
  end

  describe "enums" do
    it "defines facility types" do
      expect(Facility.facility_types.keys).to match_array([
        "pool",
        "indoor_field",
        "outdoor_field",
        "gym",
        "track",
        "other"
      ])
    end
  end

  describe "scopes" do
    let!(:active_facility) { create(:facility, active: true) }
    let!(:inactive_facility) { create(:facility, active: false) }

    it "returns active facilities" do
      expect(Facility.active).to include(active_facility)
      expect(Facility.active).not_to include(inactive_facility)
    end
  end
end
