class AddUserColumnFirstVisit < ActiveRecord::Migration
   def up
  	add_column :users, :first_visit, :boolean, :default => true
  end

  def down
  	remove_column :users, :first_visit
  end
end
