class AddUserColumnsRoundScore < ActiveRecord::Migration
    def up
  	add_column :users, :score_round1, :integer, :default => 0
  	add_column :users, :score_round2, :integer, :default => 0
  	add_column :users, :score_round3, :integer, :default => 0
  	add_column :users, :score_round4, :integer, :default => 0
  	add_column :users, :score_round5, :integer, :default => 0
  	add_column :users, :score_round6, :integer, :default => 0
  	add_column :users, :score_round7, :integer, :default => 0
  	add_column :users, :score_round8, :integer, :default => 0
  	add_column :users, :score_round9, :integer, :default => 0
  	add_column :users, :score_round10, :integer, :default => 0
  	add_column :users, :score_round11, :integer, :default => 0
  	add_column :users, :score_round12, :integer, :default => 0
  	add_column :users, :score_round13, :integer, :default => 0
  	add_column :users, :score_round14, :integer, :default => 0
  	add_column :users, :score_round15, :integer, :default => 0
  	add_column :users, :score_round16, :integer, :default => 0
  	add_column :users, :score_round17, :integer, :default => 0
  	add_column :users, :score_round18, :integer, :default => 0
  	add_column :users, :score_round19, :integer, :default => 0
  	add_column :users, :score_round20, :integer, :default => 0
  	add_column :users, :score_round21, :integer, :default => 0
  	add_column :users, :score_round22, :integer, :default => 0
  	add_column :users, :score_round23, :integer, :default => 0
  	add_column :users, :score_round24, :integer, :default => 0
  	add_column :users, :score_round25, :integer, :default => 0
  	add_column :users, :score_round26, :integer, :default => 0
  	add_column :users, :score_round27, :integer, :default => 0
  	add_column :users, :score_round28, :integer, :default => 0
  	add_column :users, :score_round29, :integer, :default => 0
  	add_column :users, :score_round30, :integer, :default => 0
  end

  def down
  	remove_column :users, :score_round1
  	remove_column :users, :score_round2
  	remove_column :users, :score_round3
  	remove_column :users, :score_round4
  	remove_column :users, :score_round5
  	remove_column :users, :score_round6
  	remove_column :users, :score_round7
  	remove_column :users, :score_round8
  	remove_column :users, :score_round9
  	remove_column :users, :score_round10
  	remove_column :users, :score_round11
  	remove_column :users, :score_round12
  	remove_column :users, :score_round13
  	remove_column :users, :score_round14
  	remove_column :users, :score_round15
  	remove_column :users, :score_round16
  	remove_column :users, :score_round17
  	remove_column :users, :score_round18
  	remove_column :users, :score_round19
  	remove_column :users, :score_round20
  	remove_column :users, :score_round21
  	remove_column :users, :score_round22
  	remove_column :users, :score_round23
  	remove_column :users, :score_round24
  	remove_column :users, :score_round25
  	remove_column :users, :score_round26
  	remove_column :users, :score_round27
  	remove_column :users, :score_round28
  	remove_column :users, :score_round29
  	remove_column :users, :score_round30
  end
end
