class AddCertificationsAndGoverningBodiesToOrganizations < ActiveRecord::Migration[8.0]
  def change
    add_column :organizations, :certifications, :string, array: true, default: []
    add_column :organizations, :national_governing_body, :string
    add_column :organizations, :regional_governing_body, :string
  end
end
