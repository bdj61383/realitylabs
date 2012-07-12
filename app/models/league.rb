class League < ActiveRecord::Base
	attr_accessible :name, :confirmation_code, :username, :password, :league_id, :contestant_pool, :scoring_system, :draft_order
	has_many :users
	# @hash = {}
	# @contestants = Contestant.all
	# @contestants.each do |x|
	# 	@hash.merge!(x.name => x.survive)
	# end
	
	serialize :contestant_pool, Hash 
	serialize :scoring_system, Hash
	serialize :draft_order, Array
	
	# This is the method by which we'll return a hash with each username as a key and their total_score as a value.
	def scoreboard
		@scoreboard = {}
		self.users.each do |user|
			# @hash = {user.username => user.total_score}
			@scoreboard.merge!(user.username => user.total_score)
		end
		return @scoreboard
	end
end