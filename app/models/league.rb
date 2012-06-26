class League < ActiveRecord::Base
	attr_accessible :name, :confirmation_code, :username, :password, :league_id
	has_many :users
end