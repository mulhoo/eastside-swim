class Event < ApplicationRecord
  belongs_to :organization
  has_many :event_entries, dependent: :destroy
  has_many :relay_teams, dependent: :destroy

  # Callbacks

  # Validations
  validates :name, presence: true
  validates :sport, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :organization_registration_url, format: URI::regexp(%w[http https]), allow_blank: true

  # Scopes
  scope :public_events, -> { where(is_public: true) }
  scope :private_events, -> { where(is_public: false) }
  scope :upcoming_events, -> { where(status: :upcoming).order(start_time: :asc) }
  scope :completed_events, -> { where(status: :completed).order(end_time: :desc) }

  # Enums
  enum status: { upcoming: 0, ongoing: 1, completed: 2, canceled: 3 }


  def active_now?
    start_time <= Time.zone.now && end_time >= Time.zone.now
  end

  def upcoming?
    start_time > Time.zone.now
  end

  def completed?
    end_time < Time.zone.now
  end
end
