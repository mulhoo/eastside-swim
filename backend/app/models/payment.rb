class Payment < ApplicationRecord
  # Associations
  belongs_to :organization
  belongs_to :athlete, optional: true
  belongs_to :user, optional: true

  # Callbacks
  before_validation :strip_whitespace

  # Validations
  validates :payment_type, presence: true
  validates :amount, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :due_date, presence: true
  validates :paid, inclusion: { in: [true, false] }

  # Enums
  enum :payment_type {
    athlete_dues: "athlete_dues",
    coach_payment: "coach_payment",
    pool_rental: "pool_rental",
    meet_entry_fee: "meet_entry_fee",
    merchandise: "merchandise",
    other: "other"
  }

  # Scopes
  scope :paid, -> { where(paid: true) }
  scope :unpaid, -> { where(paid: false) }
  scope :overdue, -> { where("due_date < ? AND paid = ?", Date.today, false) }
  scope :upcoming, -> { where("due_date >= ? AND paid = ?", Date.today, false) }
  scope :athlete_dues, -> { where(payment_type: :athlete_dues) }
  scope :coach_payments, -> { where(payment_type: :coach_payment) }
  scope :pool_rentals, -> { where(payment_type: :pool_rental) }

  def status
    return "Paid" if paid?
    return "Overdue" if due_date.past?
    "Upcoming"
  end

  private

  def strip_whitespace
    attributes.each do |attr, value|
      self[attr] = value.strip if value.is_a?(String) && value.present?
    end
  end
end
