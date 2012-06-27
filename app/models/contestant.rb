require 'rake'
class Contestant < ActiveRecord::Base
	attr_accessible :name, :survive, :immunity, :merger, :final_three, :winner, :round

	def self.rake_db_copy
    # load File.join(Rails.root, 'lib', 'tasks', 'tempfile.rake')
    # Rake::Task['db:data:dump_dir'].invoke
    @round = Contestant.find_by_id(1).round
    @time = Time.now.to_s.gsub!(/ /, '_')
    system("rake db:data:dump_dir dir=round#{@round}_#{@time}") #Apparently this isn't the most efficient way to do this, as it loads a new instance of rails or something like that.  It is working for the time being.
    # system("rake db:data:dump_dir dir=round#{@round}")
  	end
end