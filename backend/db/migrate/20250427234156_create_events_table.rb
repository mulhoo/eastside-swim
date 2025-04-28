class CreateEventsTable < ActiveRecord::Migration[8.0]
  def change
    create_table :events do |t|
      t.string :name, null: false
      t.string :sport, null: false
      t.string :description
      t.datetime :start_time, null: false
      t.datetime :end_time, null: false
      t.string :location
      t.string :event_type
      t.integer :status, default: 0
      t.string :event_url
      t.string :event_image
      t.string :registration_url
      t.datetime :registration_deadline
      t.integer :number_of_participants
      t.integer :capacity
      t.boolean :is_public, default: true
      t.decimal :cost, precision: 10, scale: 2


      t.timestamps
    end
  end
end
