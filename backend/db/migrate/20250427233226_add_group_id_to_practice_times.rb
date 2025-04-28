class AddGroupIdToPracticeTimes < ActiveRecord::Migration[8.0]
  def change
    add_reference :practice_times, :practice_groups, null: false, foreign_key: true
    add_column :practice_times, :note, :text
  end
end

