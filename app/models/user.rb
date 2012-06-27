class User < ActiveRecord::Base
	attr_accessible :username, :password, :league_id
	belongs_to :league
	serialize :team, Array
end