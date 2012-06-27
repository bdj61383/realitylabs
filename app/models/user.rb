class User < ActiveRecord::Base
	attr_accessible :username, :password, :league_id, :lc
	belongs_to :league
	serialize :team, Array

	def score
		# Here we iterate through each member of the user's team, placing the corresponding values from the league's 'scoring_system' in an empty array whenever our conditions are met.
		@sys = self.league.scoring_system
		@array = []
		self.team.each do |member|
			@con = Contestant.find_by_name(member)
			if @con.survive; @array << @sys[:survive]; end
			if @con.immunity; @array << @sys[:immunity]; end
			if @con.merger; @array << @sys[:merger]; end
			if @con.final_three; @array << @sys[:final_three]; end
			if @con.winner; @array << @sys[:winner]; end
		end
		# This adds all of the elements in the array
		return @array.reduce(:+)
	end
end