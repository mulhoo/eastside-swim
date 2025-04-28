require 'rails_helper'

RSpec.describe Organization, type: :model do
  describe "associations" do
    it { should have_many(:users).dependent(:destroy) }
    it { should have_many(:athletes).dependent(:destroy) }
    it { should have_many(:practice_times).dependent(:destroy) }
    it { should have_many(:practice_groups).dependent(:destroy) }
    it { should have_many(:events).dependent(:destroy) }
    it { should have_many(:payments).dependent(:destroy) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:address) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:zip) }
    it { should validate_presence_of(:country) }
    it { should validate_presence_of(:phone) }
    it { should validate_presence_of(:domain_name) }
    it { should validate_presence_of(:website_link) }
    it { should validate_uniqueness_of(:domain_name).case_insensitive }
  end

  describe "enums" do
    it "defines status enum" do
      expect(Organization.statuses.keys).to include("active", "inactive", "pending", "suspended")
    end
  end

  describe "scopes" do
    let!(:active_org) { create(:organization, status: :active) }
    let!(:pending_org) { create(:organization, status: :pending) }
    let!(:inactive_org) { create(:organization, status: :inactive) }
    let!(:suspended_org) { create(:organization, status: :suspended) }

    it "returns active organizations" do
      expect(Organization.active).to include(active_org)
      expect(Organization.active).not_to include(pending_org, inactive_org, suspended_org)
    end

    it "returns pending organizations" do
      expect(Organization.pending).to include(pending_org)
      expect(Organization.pending).not_to include(active_org, inactive_org, suspended_org)
    end

    it "returns inactive organizations" do
      expect(Organization.inactive).to include(inactive_org)
      expect(Organization.inactive).not_to include(active_org, pending_org, suspended_org)
    end

    it "returns suspended organizations" do
      expect(Organization.suspended).to include(suspended_org)
      expect(Organization.suspended).not_to include(active_org, pending_org, inactive_org)
    end
  end

  describe "callbacks" do
    it "normalizes the domain name before validation" do
      org = build(:organization, domain_name: " ExampleDomain.COM ")
      org.valid?
      expect(org.domain_name).to eq("exampledomain.com")
    end
  end
end
