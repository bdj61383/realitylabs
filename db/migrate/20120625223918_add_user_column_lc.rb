class AddUserColumnLc < ActiveRecord::Migration
  add_column :users, :lc, :boolean, :default => 0
end
