class EventEntry < ApplicationRecord
  # Associations
  belongs_to :organization
  belongs_to :practice_group, optional: true
  belongs_to :event
  belongs_to :athlete

  # Callbacks
  before_validation :strip_whitespace

  # Validations
  validates :event_id, presence: true
  validates :athlete_id, presence: true
  validates :competition_name, presence: true
  validates :completed, inclusion: { in: [true, false] }

  # Enums

  # Scopes
  scope :completed, -> { where(completed: true) }
  scope :upcoming, -> { where(completed: false) }
  default_scope { order(created_at: :asc) }

end
