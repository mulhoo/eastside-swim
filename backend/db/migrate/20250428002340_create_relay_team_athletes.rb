class CreateRelayTeamAthletes < ActiveRecord::Migration[8.0]
  def change
    create_table :relay_team_athletes do |t|
      t.references :relay_team, null: false, foreign_key: true
      t.references :athlete, null: false, foreign_key: true
      t.integer :order

      t.timestamps
    end
  end
end
