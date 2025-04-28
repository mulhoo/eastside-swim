class CreatePracticeTimes < ActiveRecord::Migration[8.0]
  def change
    create_table :practice_times do |t|
      t.references :organization, null: false, foreign_key: true
      t.string :group_name, null: false
      t.integer :day_of_week, null: false
      t.time :start_time, null: false
      t.time :end_time, null: false
      t.string :location_name, null: false
      t.string :location_address, null: false
      t.string :location_city, null: false
      t.string :location_state, null: false
      t.string :location_zip, null: false
      t.string :location_country, null: false

      t.timestamps
    end
  end
end
