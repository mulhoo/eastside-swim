class CreateFacility < ActiveRecord::Migration[8.0]
  def change
    create_table :facilities do |t|
      t.references :organization, null: false, foreign_key: true

      t.string :name, null: false
      t.string :address, null: false
      t.string :city, null: false
      t.string :state, null: false
      t.string :zip, null: false
      t.string :country, null: false
      t.string :phone
      t.string :website
      t.text :description
      t.integer :facility_type, null: false, default: 0
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
