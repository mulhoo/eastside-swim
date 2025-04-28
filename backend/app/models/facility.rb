class Facility < ApplicationRecord
  # Associations
  belongs_to :organization
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

  # Scopes
  scope :active, -> { where(active: true) }

  # Enums
  enum facility_type: {
    pool: 0,
    indoor_field: 1,
    outdoor_field: 2,
    gym: 3,
    track: 4,
    other: 5
  }
end
