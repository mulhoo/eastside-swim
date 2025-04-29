class AddFacilityIdToEvents < ActiveRecord::Migration[6.1]
  def change
    add_reference :events, :facility, null: false, foreign_key: true
  end
end
