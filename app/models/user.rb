class User < ActiveRecord::Base
	attr_accessible :username, :password, :password_confirmation, :league_id, :lc, :team, :last_seen, :email, :first_name, :last_name
	belongs_to :league
	serialize :team, Array

	has_secure_password
  validates_presence_of :password, :on => :save
  validates :username, :length => { :maximum => 15 }, :uniqueness => true, :allow_blank => false, :presence => true, :on => :create
  validates_format_of :username, :with => /^[A-Za-z\d_]+$/, :message => "can only contain letters and numbers, with no spaces"

  	def online
  		if self.last_seen > DateTime.now - 10.minutes
  	    	return true
  		else
  			return false	
  		end
  	end

	def score
		# Here we iterate through each member of the user's team, placing the corresponding values from the league's 'scoring_system' in an empty array whenever our conditions are met.
		@sys = self.league.scoring_system
		@array = []
		@round = Contestant.first.round
		unless @round == 0
			self.team.each do |member|
				@con = Contestant.find_by_name(member)
				if @con.survive; @array << @sys[:survive]; end
				if @con.immunity; @array << @sys[:immunity]; end
				if @con.merger; @array << @sys[:merger]; end
				if @con.final_three; @array << @sys[:final_three]; end
				if @con.winner; @array << @sys[:winner]; end
			end
			unless @array == []
			# This adds all of the elements in the array
				return @array.reduce(:+)
			else 
				return 0
			end
		else # This just handles the initial case, before the game has started.  The :survive attribute of Contestants has been set to '1', but I don't want that to count towards the score.  Everyone's initial score should be zero.
			return 0
		end
	end

	# This finds the score value for each of the user's rounds, puts them in an array and adds them together to create a total score that is up to date.
	def total_score
		@array = []
		self.attributes.each do |key, value|
			if key.to_s =~ /^score/
				@array << value
			end
		end
		unless @array ==[]
			return @array.reduce(:+)
		else
			return 0
		end
	end

	# def self.add_column  -- If you ever want to go back in and get this method working on Heroku, your problem is most likely with the '.to_s' method you're running on the 'filename' definition below.
	# 	@round = Contestant.find_by_id(1).round 
	# 	system("rails generate migration AddUserColumnRound#{@round}")
	# 	filename = Dir.entries("db/migrate").select {|x| x =~ /_add_user_column_round#{@round}/}.to_s
	# 	file = File.open("db/migrate/#{filename}", "w+") 
	# 	file.write("class AddUserColumnRound#{@round} < ActiveRecord::Migration\n  def up\n    add_column :users, :score_round#{@round}, :integer\n  end\n  def down\n    remove_column :users, :score_round#{@round}\n  end\nend")
	# 	file.close
	# 	system("rake db:migrate")
	# 	self.reset_column_information
	# end

	def send_password_reset
	  generate_token(:password_reset_token)
	  self.password_reset_sent_at = Time.zone.now
	  save!
	  Invite.password_reset(self).deliver
	end

	def generate_token(column)
	  begin  
	    self[column] = SecureRandom.base64.tr("+/", "-_")
	  end while User.exists?(column => self[column])
	end
end

