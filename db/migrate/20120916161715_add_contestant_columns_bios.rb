class AddContestantColumnsBios < ActiveRecord::Migration
  def up
  	add_column :contestants, :nickname, :string
  	add_column :contestants, :tribe, :string	
  	add_column :contestants, :age, :integer
  	add_column :contestants, :hometown, :string
  	add_column :contestants, :occupation, :string
  	add_column :contestants, :preseason_rank, :integer
  	add_column :contestants, :labwork, :string
  end

  def down
  	remove_column :contestants, :nickname, :string
  	remove_column :contestants, :tribe, :string	
  	remove_column :contestants, :age, :integer
  	remove_column :contestants, :hometown, :string
  	remove_column :contestants, :occupation, :string
  	remove_column :contestants, :preseason_rank, :integer
  	remove_column :contestants, :labwork, :string
  end
end


