class AddLeagueColumnTeamsize < ActiveRecord::Migration
   def up
  	add_column :leagues, :teamsize, :integer, :default => 1
  end

  def down
  	remove_column :leagues, :teamsize
  end
end
