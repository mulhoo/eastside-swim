class RelayTeam < ApplicationRecord
  # Associations
  belongs_to :organization
  belongs_to :practice_group, optional: true
  belongs_to :event
  has_many :relay_team_athletes, dependent: :destroy
  has_many :athletes, through: :relay_team_athletes

  # Callbacks

  # Validations
  validates :team_name, presence: true
  validates :event_id, presence: true
  validates :heat_number, numericality: { only_integer: true }, allow_nil: true
  validates :lane_number, numericality: { only_integer: true }, allow_nil: true

  # Enums

  # Scopes
  scope :completed, -> { where(completed: true) }
  scope :upcoming, -> { where(completed: false) }
  scope :ordered_by_race, -> { order(:heat_number, :lane_number) }

  def ordered_athletes
    relay_team_athletes.includes(:athlete).order(:order).map(&:athlete)
  end
end
