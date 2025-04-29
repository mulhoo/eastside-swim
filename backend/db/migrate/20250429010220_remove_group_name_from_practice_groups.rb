class RemoveGroupNameFromPracticeGroups < ActiveRecord::Migration[8.0]
  def change
    remove_column :practice_groups, :group_name, :string
  end
end
