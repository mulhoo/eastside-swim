class RemoveGroupNameFromPracticeTimes < ActiveRecord::Migration[8.0]
  def change
    remove_column :practice_times, :group_name, :string
    rename_column :practice_times, :practice_groups_id, :practice_group_id
  end
end