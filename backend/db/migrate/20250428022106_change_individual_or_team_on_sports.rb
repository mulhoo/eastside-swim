class ChangeIndividualOrTeamOnSports < ActiveRecord::Migration[8.0]
  def up
    execute <<-SQL
      ALTER TABLE sports
      ALTER COLUMN individual_or_team DROP DEFAULT;
    SQL

    execute <<-SQL
      ALTER TABLE sports
      ALTER COLUMN individual_or_team TYPE integer USING CASE
        WHEN individual_or_team = 'individual' THEN 0
        WHEN individual_or_team = 'team' THEN 1
        WHEN individual_or_team = 'both' THEN 2
        ELSE 0
      END;
    SQL

    execute <<-SQL
      ALTER TABLE sports
      ALTER COLUMN individual_or_team SET DEFAULT 0,
      ALTER COLUMN individual_or_team SET NOT NULL;
    SQL
  end

  def down
    change_column :sports, :individual_or_team, :string
  end
end
