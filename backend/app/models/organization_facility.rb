class OrganizationFacility < ApplicationRecord
  belongs_to :organization
  belongs_to :facility

  validates :organization_id, presence: true
  validates :facility_id, presence: true

  validates :facility_id, uniqueness: { scope: :organization_id }
end
