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
      expect(User.roles.keys).to include("admin", "head_coach", "assistant_coach")
    end
  end

  describe "scopes" do
    let!(:admin_user) { create(:user, role: :admin) }
    let!(:head_coach_user) { create(:user, role: :head_coach) }

    it "returns active users" do
      expect(User.active).to include(admin_user, head_coach_user)
    end

    it "returns users by role" do
      expect(User.admins).to include(admin_user)
      expect(User.coaches).to include(head_coach_user)
    end
  end
end