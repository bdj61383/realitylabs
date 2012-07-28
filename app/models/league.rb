class League < ActiveRecord::Base
	attr_accessible :name, :confirmation_code, :username, :password, :league_id, :contestant_pool, :scoring_system, :draft_order, :draft_active, :draft_round, :draft_start
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
    		system(%Q[curl http://localhost:9292/faye -d 'message={"channel":"/#{self.id}/draft/auto_pick", "data":"data"}'])
		end
		# self.update_attribute('draft_start', 'false')
		# system(%Q[curl http://localhost:9292/faye -d 'message={"channel":"/#{self.id}/draft/start", "data":"data"}'])
		# self.draft_order.each do |username|
		# 	user = self.users.find_by_username(username)
		# 	next_round = self.draft_round + 1
		# 	teamsize = user.team.size
			# if user.online == false
			# 	choice = self.contestant_pool.reject{|key, value| value == false}.keys.sample
			# 	team = user.team << choice
			# 	user.update_attribute("team", team)
			# 	self.contestant_pool[choice] = false
			# 	self.update_attribute("draft_round", next_round)
   #  			choice = choice.gsub(" ", "_")
    			
    			
   #  			system(%Q[curl http://localhost:9292/faye -d 'message={"channel":"/draft/auto", "data":{"username":"#{user.username}", "team":"#{user.team}", "member":"#{choice}"}'])
   #  			sleep(2)
   #  			system(%Q[curl http://localhost:9292/faye -d 'message={"channel":"/draft/pick", "data":"data"}'])

  #   		else
    			
  #   			for i in 0..20
  #   				newsize = user.team.size
  #   				unless newsize > teamsize
  #   					sleep(1)
  #   				else
  #   					choice = user.team.last
  #   					self.contestant_pool[choice] = false
  #   					self.update_attribute("draft_round", next_round)
  #   					system(%Q[curl http://localhost:9292/faye -d 'message={"channel":"/draft/pick", "data":"data"}'])

  #   					break
  #   				end
  #   				user.reload
  #   			end
  #   			if user.team.size > teamsize
  #   				next
  #   			else
  #   				choice = self.contestant_pool.reject{|key, value| value == false}.keys.sample
		# 			team = user.team << choice
		# 			user.update_attribute("team", team)
		# 			self.contestant_pool[choice] = false
	 #    			self.update_attribute("draft_round", next_round)

	 #    			choice = choice.gsub(" ", "_")
	 #    			system(%Q[curl http://localhost:9292/faye -d 'message={"channel":"/draft/pick", "data":"data"}'])
	 #    		end
		# 	end
		# end
		# sleep(1.5)
		# system(%Q[curl http://localhost:9292/faye -d 'message={"channel":"/draft/stop", "data":"data"}'])
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