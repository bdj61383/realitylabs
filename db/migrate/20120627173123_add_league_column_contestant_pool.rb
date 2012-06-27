class AddLeagueColumnContestantPool < ActiveRecord::Migration
	def up
  		add_column :leagues, :contestant_pool, :text
  	end

  	def down
  		remove_column :league, :contestant_pool
  	end
end
