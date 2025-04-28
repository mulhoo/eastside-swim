class Organization < ApplicationRecord
  # Associations
  balongs_to :sport, optional: true
  has_many :users, dependent: :destroy
  has_many :athletes, dependent: :destroy
  has_many :practice_times, dependent: :destroy
  has_many :practice_groups, dependent: :destroy

  # Callbacks
  before_validation :normalize_domain_name
  before_validation :strip_whitespace
  after_initialize :set_default_team_site_settings, if: :new_record?

  # Validations
  validates :name, presence: true
  validates :address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip, presence: true
  validates :country, presence: true
  validates :phone, presence: true
  validates :domain_name, presence: true, uniqueness: true
  validates :website_link, presence: true
  validates :organization_type, presence: true

  # Scopes
  scope :active, -> { where(status: :active) }
  scope :pending, -> { where(status: :pending) }
  scope :inactive, -> { where(status: :inactive) }
  scope :suspended, -> { where(status: :suspended) }

  # Enums
  enum status: {
    active: 0,
    inactive: 1,
    pending: 2,
    suspended: 3
  }

  enum organization_type: {
    club: 0,
    high_school: 1,
    college: 2,
    masters: 3,
    youth_year_round: 4,
    rec_seasonal: 5
  }

  # Constants
  DEFAULT_TEAM_SITE_SETTINGS = {
    "primary_color": "#0055FF",
    "secondary_color": "#FFC300",
    "background_color": "#FFFFFF",
    "logo_url": null,
    "banner_image_url": null,
    "custom_domain": null,
    "show_schedule": true,
    "show_tryouts": true,
    "show_team_store": false,
    "theme_style": "modern",
    "allowed_languages": ["en", "es", "fr"]
  }.freeze

  def reset_team_site_settings!
    update!(team_site_settings: DEFAULT_TEAM_SITE_SETTINGS)
  end

  private

  def normalize_domain_name
    self.domain_name = domain_name.strip.downcase if domain_name.present?
  end

  def strip_whitespace
    attributes.each do |attr, value|
      if value.is_a?(String)
        self[attr] = value.strip unless value.nil?
      end
    end
  end

  def set_default_team_site_settings
    self.team_site_settings = DEFAULT_TEAM_SITE_SETTINGS.merge(team_site_settings || {})
  end
end
