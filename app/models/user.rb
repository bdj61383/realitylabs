class User < ActiveRecord::Base
	attr_accessible :username, :password, :league_id, :lc, :team
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

	def self.add_column
		@round = Contestant.find_by_id(1).round 
		system("rails generate migration AddUserColumnRound#{@round}")
		filename = Dir.entries("db/migrate").select {|x| x =~ /_add_user_column_round#{@round}/}.to_s
		file = File.open("db/migrate/#{filename}", "w+") 
		file.write("class AddUserColumnRound#{@round} < ActiveRecord::Migration\n  def up\n    add_column :users, :score_round#{@round}, :integer\n  end\n  def down\n    remove_column :users, :score_round#{@round}\n  end\nend")
		file.close
		system("rake db:migrate")
	end
end