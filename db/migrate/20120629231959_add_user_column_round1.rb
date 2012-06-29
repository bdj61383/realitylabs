class AddUserColumnRound1 < ActiveRecord::Migration
  def up
    add_column :users, :score_round1, :integer
  end
  def down
    remove_column :users, :score_round1
  end
end