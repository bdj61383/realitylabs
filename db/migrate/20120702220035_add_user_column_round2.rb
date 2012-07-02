class AddUserColumnRound2 < ActiveRecord::Migration
  def up
    add_column :users, :score_round2, :integer
  end
  def down
    remove_column :users, :score_round2
  end
end