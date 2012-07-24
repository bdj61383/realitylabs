class AddLeagueColumnDraftActive < ActiveRecord::Migration
  def up
  	add_column :leagues, :draft_active, :boolean, :default => false
  end

  def down
  	remove_column :leagues, :draft_active
  end
end
