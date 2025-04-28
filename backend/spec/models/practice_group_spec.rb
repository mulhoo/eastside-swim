require 'rails_helper'

RSpec.describe PracticeGroup, type: :model do
  describe "associations" do
    it { should belong_to(:organization) }
    it { should have_many(:practice_times).dependent(:destroy) }
    it { should have_many(:athletes).dependent(:nullify) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:age_min) }
    it { should validate_presence_of(:age_max) }
  end

  describe "scopes" do
    it "returns groups matching an athlete's age" do
      group = create(:practice_group, age_min: 10, age_max: 12)
      expect(PracticeGroup.for_age(11)).to include(group)
      expect(PracticeGroup.for_age(9)).not_to include(group)
    end
  end

  describe "instance methods" do
    it "returns the correct age range" do
      group = build(:practice_group, age_min: 10, age_max: 12)
      expect(group.age_range).to eq("10-12")
    end
  end
end
