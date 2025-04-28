class Athlete < ApplicationRecord
  # Associations
  belongs_to :organization
  belongs_to :practice_group, optional: true

  # Associations
  has_many :event_entries, dependent: :destroy
  has_many :relay_team_athletes, dependent: :destroy
  has_many :relay_teams, through: :relay_team_athletes
  has_many :payments, dependent: :nullify # Only if you connect payments to athletes

  # Validations
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :date_of_birth, presence: true
  validates :active, inclusion: { in: [true, false] }

  # Callbacks
  before_validation :strip_whitespace

  # Enums

  # Scopes
  scope :active, -> { where(active: true) }
  scope :inactive, -> { where(active: false) }
  scope :birthday_this_month, -> {
    where("EXTRACT(MONTH FROM date_of_birth) = ?", Time.zone.now.month)
  }

  scope :ordered_by_name, -> { order(:last_name, :first_name) }
  scope :ordered_by_dob, -> { order(:date_of_birth) }
  scope :ordered_by_age, -> { order("EXTRACT(YEAR FROM age(date_of_birth)) DESC") }
  scope :ordered_by_practice_group, -> { joins(:practice_group).order("practice_groups.name") }
  scope :ordered_by_practice_group_and_name, -> {
    joins(:practice_group).order("practice_groups.name, athletes.last_name, athletes.first_name")
  }

  scope :in_practice_group, ->(practice_group_id) { where(practice_group_id: practice_group_id) }
  scope :not_in_practice_group, ->(practice_group_id) { where.not(practice_group_id: practice_group_id) }
  scope :with_practice_group, -> { where.not(practice_group_id: nil) }
  scope :without_practice_group, -> { where(practice_group_id: nil) }
  scope :assigned, -> { where.not(practice_group_id: nil) }
  scope :unassigned, -> { where(practice_group_id: nil) }

  def age
    return unless date_of_birth

    today = Time.zone.today
    age = today.year - date_of_birth.year
    age -= 1 if today < date_of_birth + age.years
    age
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def age_group
    return unless date_of_birth

    today = Time.zone.today
    age = today.year - date_of_birth.year
    age -= 1 if today < date_of_birth + age.years

    case age
    when 0..6
      "6 & Under"
    when 7..10
      "10 & Under"
    when 11..12
      "12 & Under"
    when 13..14
      "14 & Under"
    when 15..16
      "16 & Under"
    when 17..18
      "18 & under"
    end
  end

  private

  def strip_whitespace
    attributes.each do |attr, value|
      if value.is_a?(String)
        self[attr] = value.strip unless value.nil?
      end
    end
  end
end
