class AddUserColumnLaumnLastSeen < ActiveRecord::Migration
  def up
  	add_column :users, :last_seen, :datetime 
  end

  def down
  	remove_column :users, :last_seen
  end
end
