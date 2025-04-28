class CreateSports < ActiveRecord::Migration[8.0]
  def change
    create_table :sports do |t|
      t.string :name, null: false
      t.string :category
      t.string :seasonality
      t.string :individual_or_team, default: "individual"
      t.string :governing_body
      t.string :official_website
      t.text :description
      t.string :rules_url
      t.text :equipment_needed
      t.string :icon_url
      t.boolean :active, default: true

      t.timestamps
    end

    add_reference :organizations, :sport, foreign_key: true
    add_reference :events, :sport, foreign_key: true
    add_index :sports, :name, unique: true
  end
end
