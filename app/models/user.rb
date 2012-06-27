class User < ActiveRecord::Base
	attr_accessible :username, :password, :league_id, :lc
	belongs_to :league
	serialize :team, Array

	def score
		# First, convert the user's 'team' array to an array with hashes as its elements, representing the results of this week.
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
		@total = @array.inject(0) {|result, element| result + element}
		return @total
	end
end