class UpdateFacilitiesForMultipleOrganizations < ActiveRecord::Migration[6.1]
  def change
    remove_reference :facilities, :organization, foreign_key: true

    create_table :organization_facilities do |t|
      t.references :organization, null: false, foreign_key: true
      t.references :facility, null: false, foreign_key: true

      t.timestamps
    end

    add_index :organization_facilities, [:organization_id, :facility_id], unique: true, name: "index_org_facilities"
  end
end
