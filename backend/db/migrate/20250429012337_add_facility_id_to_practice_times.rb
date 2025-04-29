class AddFacilityIdToPracticeTimes < ActiveRecord::Migration[6.1]
  def change
    add_reference :practice_times, :facility, null: false, foreign_key: true
  end
end
