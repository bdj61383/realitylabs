class League < ActiveRecord::Base
	attr_accessible :name, :confirmation_code, :username, :password, :league_id, :contestant_pool, :scoring_system, :draft_order, :draft_active, :draft_round, :draft_start, :team_size
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

	# This is the draft method.
	def auto_draft(user)
		user = User.find_by_username(user)
		if user.online == false 
			choice = self.contestant_pool.reject{|key, value| value == false}.keys.sample
			team = user.team << choice
			user.update_attribute("team", team)
			self.contestant_pool[choice] = false
			next_round = self.draft_round + 1
			self.update_attribute("draft_round", next_round)				
    		choice = choice.gsub(" ", "_")
    		system(%Q[curl http://realitylabs-server.herokuapp.com/faye -d 'message={"channel":"/#{self.id}/draft/auto_pick", "data":"data"}'])
		end
	end

	def test
		teamsize = self.users[0].team.size
		puts teamsize
		20.times do
			newsize = self.users[0].team.size
			if newsize > teamsize
				puts "working"
				break
			else
				puts newsize
			end
			sleep(1)
			self.users[0].reload
		end
	end
end