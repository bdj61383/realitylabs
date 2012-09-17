require 'rake'
class Contestant < ActiveRecord::Base
	attr_accessible :name, :survive, :immunity, :merger, :final_three, :winner, :round, :occupation, :tribe, :hometown, :labwork, :nickname, :preseason_rank, :age

	def self.rake_db_copy
	    # load File.join(Rails.root, 'lib', 'tasks', 'tempfile.rake')
	    # Rake::Task['db:data:dump_dir'].invoke

	    # Looks to see if the database copy already exists.  If so, it deletes it and puts the new copy in.
	    @round = Contestant.first.round
	    @time = Time.now.to_s.gsub!(/ /, '_')
	    @dir = Dir.entries("db").select {|x| x =~ /^round#{@round}/}.join
	    	if @dir != ""
	    		system("rm -rf db/#{@dir}")
	    		# @dir.each do |directory|
				# system("rm -rf db/#{directory.to_s}")
				# end
			end
	    system("rake db:data:dump_dir dir=round#{@round}_#{@time}") #Apparently this isn't the most efficient way to do this, as it loads a new instance of rails or something like that.  It is working for the time being.
	    # system("rake db:data:dump_dir dir=round#{@round}")
  	end

  	def self.rake_db_load # This reloads the results of the previous round.
  		@last_round = Contestant.first.round - 1
  		@dir = Dir.entries("db").select{|x| x =~ /^round#{@last_round}/}.join
  		system("rake db:data:load_dir dir=#{@dir}")
  	end
end