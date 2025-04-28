require 'rails_helper'

RSpec.describe User, type: :model do
  describe "associations" do
    it { should belong_to(:organization) }
  end

  describe "validations" do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:role) }
  end

  describe "enums" do
    it "defines user roles" do
      expect(User.roles.keys).to include("member", "coach", "admin")
    end
  end

  describe "scopes" do
    let!(:admin_user) { create(:user, role: :admin) }
    let!(:coach_user) { create(:user, role: :coach) }
    let!(:member_user) { create(:user, role: :member) }
    let!(:inactive_user) { create(:user, active: false) }

    it "returns active users" do
      expect(User.where(active: true)).to include(admin_user, coach_user, member_user)
      expect(User.where(active: true)).not_to include(inactive_user)
    end

    it "returns users by role" do
      expect(User.admin).to include(admin_user)
      expect(User.coach).to include(coach_user)
      expect(User.member).to include(member_user)
    end
  end
end
