class AddLeagueColumnDraftRound < ActiveRecord::Migration
  def up
  	add_column :leagues, :draft_round, :integer, :default => 0
  end

  def down
  	remove_column :leagues, :draft_round
  end
end
