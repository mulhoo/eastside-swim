class Facility < ApplicationRecord
  # Associations
  has_many :organization_facilities
  has_many :organizations, through: :organization_facilities
  has_many :events
  has_many :practice_times
  has_many :tryouts

  # Callbacks

  # Validations
  validates :name, presence: true
  validates :address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip, presence: true
  validates :country, presence: true
  validates :facility_type, presence: true

  # Enums
  enum :facility_type, {
    pool: 0,
    indoor_field: 1,
    outdoor_field: 2,
    gym: 3,
    track: 4,
    other: 5
  }

  # Scopes
  scope :active, -> { where(active: true) }
end
