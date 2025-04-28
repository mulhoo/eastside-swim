class UpdateEventsAddHostAndOrganizationAndRenameRegistrationUrl < ActiveRecord::Migration[8.0]
  def change
    add_column :events, :host, :string
    add_reference :events, :organization, null: false, foreign_key: true
    rename_column :events, :registration_url, :organization_registration_url
  end
end
