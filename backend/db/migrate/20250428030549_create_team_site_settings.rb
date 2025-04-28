class CreateTeamSiteSettings < ActiveRecord::Migration[8.0]
  def change
    create_table :team_site_settings do |t|
      t.timestamps
    end
  end
end
