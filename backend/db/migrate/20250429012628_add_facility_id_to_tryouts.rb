class AddFacilityIdToTryouts < ActiveRecord::Migration[6.1]
  def change
    add_reference :tryouts, :facility, null: true, foreign_key: true
  end
end
 