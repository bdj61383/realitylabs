class AddUserColumnLc < ActiveRecord::Migration
	def up
  		add_column :users, :lc, :boolean, :default => 0
  	end

  	def down
  		remove_column :users, :lc
  	end
end