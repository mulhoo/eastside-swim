class Tryout < ApplicationRecord
  # Associations
  belongs_to :organization
  belongs_to :facility, optional: true

  # Validations
  validates :start_date, presence: true
  validates :form_structure, presence: true

  # Enums

  # Scopes
  scope :active, -> { where(active: true) }
  scope :upcoming, -> { where("start_date >= ?", Date.today).order(start_date: :asc) }
  scope :past, -> { where("start_date < ?", Date.today).order(start_date: :desc) }

  def currently_open?
    active && start_date <= Date.today && (end_date.nil? || end_date >= Date.today)
  end
end
