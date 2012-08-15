league = League.last
league.contestant_pool.each_key do |key|
	league.contestant_pool[key] = true
end
league.users.each do |x|
	x.team = []
	x.save
end
league.update_attributes(:draft_active => false, :draft_start => false, :draft_order => [], :draft_round => 0)
league.save