class RemoveSportFromOrganization < ActiveRecord::Migration[8.0]
  def change
    remove_column :organizations, :sport, :string
  end
end
