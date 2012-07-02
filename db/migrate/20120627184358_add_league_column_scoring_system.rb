class AddLeagueColumnScoringSystem < ActiveRecord::Migration
  def up
  	add_column :leagues, :scoring_system, :text
  end

  def down
  	remove_column :leagues, :scoring_system
  end
end