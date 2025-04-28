class CreateRelayTeams < ActiveRecord::Migration[8.0]
  def change
    create_table :relay_teams do |t|
      t.references :event, null: false, foreign_key: true
      t.string :team_name, null: false
      t.integer :heat_number
      t.integer :lane_number
      t.string :team_color
      t.string :result_time
      t.integer :placement
      t.boolean :completed, default: false
      t.text :notes

      t.timestamps
    end
  end
end
