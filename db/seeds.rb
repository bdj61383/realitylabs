# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Emanuel', :city => cities.first)

Contestant.create!(:name => "Billy Madison", :survive => 1, :immunity => 0, :merger => 0, :final_three => 0, :winner => 0, :round => 7)
Contestant.create!(:name => "Richard Price", :survive => 1, :immunity => 1, :merger => 0, :final_three => 0, :winner => 0, :round => 7)
Contestant.create!(:name => "Allison Andrews", :survive => 0, :immunity => 0, :merger => 0, :final_three => 0, :winner => 0, :round => 7)
Contestant.create!(:name => "Burt Reynolds", :survive => 1, :immunity => 0, :merger => 1, :final_three => 0, :winner => 0, :round => 7)
Contestant.create!(:name => "Samantha Firth", :survive => 1, :immunity => 0, :merger => 1, :final_three => 1, :winner => 1, :round => 7)
