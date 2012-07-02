class AddUserColumnRound3 < ActiveRecord::Migration
  def up
    add_column :users, :score_round3, :integer
  end
  def down
    remove_column :users, :score_round3
  end
end