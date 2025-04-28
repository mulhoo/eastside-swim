class RelayTeamAthlete < ApplicationRecord
  # Association
  belongs_to :relay_team
  belongs_to :athlete

  # Callbacks

  # Validations
  validates :order, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :order, uniqueness: { scope: :relay_team_id }

  # Scopes
  scope :ordered, -> { order(:order) }


  # Enums

  def leg_name
    case order
    when 1 then "Starter"
    when 2 then "Second"
    when 3 then "Third"
    when 4 then "Anchor"
    else "Leg #{order}"
    end
  end

end
