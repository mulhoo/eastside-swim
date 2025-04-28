class CreateTryouts < ActiveRecord::Migration[8.0]
  def change
    create_table :tryouts do |t|
      t.references :organization, null: false, foreign_key: true
      t.references :sport, foreign_key: true
      t.string :name, null: false
      t.text :description
      t.date :start_date
      t.date :end_date
      t.string :location_name
      t.string :location_address
      t.string :location_city
      t.string :location_state
      t.string :location_zip
      t.string :location_country
      t.jsonb :form_structure, default: {}
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
