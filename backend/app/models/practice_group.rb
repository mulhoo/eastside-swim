class PracticeGroup < ApplicationRecord
  # Associations
  belongs_to :organization
  has_many :practice_times

  # Callbacks
  before_validation :strip_practice_days

  # Validations
  validates :name, presence: true
  validates :age_min, presence: true
  validates :age_max, presence: true
  validates :age_min, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :age_max, numericality: { only_integer: true, greater_than: :age_min }

  # Scopes
  scope :for_age, ->(age) { where("age_min <= ? AND age_max >= ?", age, age) }

  # Enums

  def age_range
    "#{age_min}-#{age_max}"
  end

  private

  def strip_practice_days
    if practice_days.is_a?(Array)
      self.practice_days = practice_days.map(&:strip)
    end
  end
end
