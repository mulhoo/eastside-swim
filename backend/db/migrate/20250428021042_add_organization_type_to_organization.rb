class AddOrganizationTypeToOrganization < ActiveRecord::Migration[8.0]
  def change
    add_column :organizations, :organization_type, :integer, default: 0, null: false
  end
end
