class Sport < ApplicationRecord
  # Associations
  has_many :organizations
  has_many :events

  # Callbacks

  # Validations
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :category, presence: true

  # Scopes
  scope :active, -> { where(active: true) }
  scope :inactive, -> { where(active: false) }

  # Enums
  enum individual_or_team: {
    individual: 0,
    team: 1,
    both: 2
  }
end

