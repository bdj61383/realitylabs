class AddLeagueColumnDraftStart < ActiveRecord::Migration
  def up
  	add_column :leagues, :draft_start, :boolean, :default => false
  end

  def down
  	remove_column :leagues, :draft_round
  end
end
