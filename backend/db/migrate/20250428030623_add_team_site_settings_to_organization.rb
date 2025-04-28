class AddTeamSiteSettingsToOrganization < ActiveRecord::Migration[8.0]
  def change
    add_column :organizations, :team_site_settings, :jsonb, default: {}, null: false
  end
end
