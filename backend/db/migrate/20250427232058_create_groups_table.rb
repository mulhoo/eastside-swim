class CreateGroupsTable < ActiveRecord::Migration[8.0]
  def change
    create_table :practice_groups do |t|
      t.string :name, null: false
      t.string :description
      t.references :organization, null: false, foreign_key: true
      t.string :group_name, null: false
      t.string :practice_days, array: true, default: []
      t.integer :age_min, null: false
      t.integer :age_max, null: false

      t.timestamps
    end
  end
end
