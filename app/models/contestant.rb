class Contestant < ActiveRecord::Base
	attr_accessible :name, :survive, :immunity, :merger, :final_three, :winner, :round
end