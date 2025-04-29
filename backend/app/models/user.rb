class User < ApplicationRecord
  # Associations
  belongs_to :organization

  # Callbacks
  has_secure_password

  # Validations
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true, format: URI::MailTo::EMAIL_REGEXP
  validates :role, presence: true

  # Enums
  enum :role, {
    head_coach: 0,
    admin: 1,
    manager: 2,
    superadmin: 3,
    assistant_coach: 4,
    volunteer: 5
  }

  # Scopes
  scope :active, -> { where(active: true) }
  scope :inactive, -> { where(active: false) }
  scope :admins, -> { where(role: :admin) }

  scope :coaches, -> { where(role: [:head_coach, :assistant_coach]) }
  scope :volunteers, -> { where(role: :volunteer) }
  scope :active_coaches, -> { active.coaches }


  def full_name
    "#{first_name} #{last_name}".strip
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
