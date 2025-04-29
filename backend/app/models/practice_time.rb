class PracticeTime < ApplicationRecord
  # Associations
  belongs_to :event
  belongs_to :athlete
  belongs_to :event_entry, optional: true
  belongs_to :organization
  belongs_to :practice_group
  belongs_to :facility, optional: true

  # Callbacks
  validate :end_time_after_start_time

  # Validations
  validates :day_of_week, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :location_name, presence: true
  validates :location_address, presence: true
  validates :location_city, presence: true
  validates :location_state, presence: true
  validates :location_zip, presence: true
  validates :location_country, presence: true

  # Enum
  enum :day_of_week, {
    sunday: 0,
    monday: 1,
    tuesday: 2,
    wednesday: 3,
    thursday: 4,
    friday: 5,
    saturday: 6
  }

  # Scopes
  scope :on_day, ->(day) { where(day_of_week: day) }

  def time_range
    "#{start_time.strftime("%I:%M %p")} - #{end_time.strftime("%I:%M %p")}"
  end

  private

  def end_time_after_start_time
    if start_time.present? && end_time.present? && end_time <= start_time
      errors.add(:end_time, "must be after the start time")
    end
  end
end
