# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Emanuel', :city => cities.first)

Contestant.create!(:name => "Billy Madison", :survive => 1, :immunity => 0, :merger => 0, :final_three => 0, :winner => 0, :round => 0)
Contestant.create!(:name => "Richard Price", :survive => 1, :immunity => 0, :merger => 0, :final_three => 0, :winner => 0, :round => 0)
Contestant.create!(:name => "Allison Andrews", :survive => 1, :immunity => 0, :merger => 0, :final_three => 0, :winner => 0, :round => 0)
Contestant.create!(:name => "Burt Reynolds", :survive => 1, :immunity => 0, :merger => 0, :final_three => 0, :winner => 0, :round => 0)
Contestant.create!(:name => "Samantha Firth", :survive => 1, :immunity => 0, :merger => 0, :final_three => 0, :winner => 0, :round => 0)

# League.create!(:name => "Extraordinary Gentlemen", :confirmation_code => "code", :contestant_pool => {"Billy Madison" => 1, "Richard Price" => 1, "Allison Andrews" => 1, "Burt Reynolds" => 1, "Samantha Firth" => 1}, :scoring_system => {:survive => 1, :immunity => 1, :merger => 1, :final_three => 1, :winner => 1})

# User.create!(:username => 'brian', :password_digest => '$2a$10$m8jxT.SZ.UCr6qTSpOj3GOcIy18r0v5F.SgrrOXM3q.9p8h/0dVCe', :league_id => 1, :team => ['Billy Madison', 'Samantha Firth'], :lc => 1)
# User.create!(:username => 'joey', :password_digest => '$2a$10$m8jxT.SZ.UCr6qTSpOj3GOcIy18r0v5F.SgrrOXM3q.9p8h/0dVCe', :league_id => 1, :team => ['Burt Reynolds', 'Allison Andrews'], :lc => 0)
# User.create!(:username => 'peter', :password_digest => '$2a$10$m8jxT.SZ.UCr6qTSpOj3GOcIy18r0v5F.SgrrOXM3q.9p8h/0dVCe', :league_id => 1, :team => ['Richard Price'], :lc => 0)