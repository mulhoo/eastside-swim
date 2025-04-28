class CreateEventEntries < ActiveRecord::Migration[8.0]
  def change
    create_table :event_entries do |t|
      t.references :event, null: false, foreign_key: true
      t.references :athlete, null: false, foreign_key: true

      t.string :competition_name, null: false
      t.integer :heat_number
      t.integer :lane_number
      t.string :team_color
      t.string :result_time
      t.integer :score
      t.integer :placement
      t.boolean :personal_best, default: false
      t.text :notes
      t.boolean :completed, default: false

      t.timestamps
    end
  end
end
