class CreateAthletes < ActiveRecord::Migration[8.0]
  def change
    create_table :athletes do |t|
      t.references :organization, null: false, foreign_key: true
      t.references :practice_group, null: true, foreign_key: true
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email, null: true
      t.string :phone
      t.string :prefered_contact_method, default: "email"
      t.date :date_of_birth
      t.string :gender
      t.string :address
      t.string :city
      t.string :state
      t.string :zip
      t.string :country
      t.boolean :active, default: true
      t.string :emergency_contact_name
      t.string :emergency_contact_phone
      t.text :notes

      t.timestamps
    end

    add_index :athletes, [:organization_id, :last_name]
  end
end
