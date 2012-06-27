class League < ActiveRecord::Base
	attr_accessible :name, :confirmation_code, :username, :password, :league_id, :contestant_pool, :scoring_system
	has_many :users
	# @hash = {}
	# @contestants = Contestant.all
	# @contestants.each do |x|
	# 	@hash.merge!(x.name => x.survive)
	# end
	
	serialize :contestant_pool, Hash 
	serialize :scoring_system, Hash
	
end