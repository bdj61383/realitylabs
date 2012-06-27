class AddLeagueColumnContestantPool < ActiveRecord::Migration
  add_column :leagues, :contestant_pool, :text
end
