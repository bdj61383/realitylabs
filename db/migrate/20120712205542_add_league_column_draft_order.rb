class AddLeagueColumnDraftOrder < ActiveRecord::Migration
  def up
  	add_column :leagues, :draft_order, :text
  end

  def down
  	remove_column :leagues, :draft_order
  end
end
