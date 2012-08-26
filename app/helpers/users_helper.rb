module UsersHelper
	def lc_sidebar
		if @user.lc == true && @league.draft_start == false
			capture_haml do
				haml_tag :li, :id => 'lc_list' do 
					haml_concat "Commissioner Tools"
				end
				# haml_tag :li do
				# 	haml_concat link_to "Draft Setup", draft_league_path(@league)
				# end
			end
		elsif @user.lc == true 
			capture_haml do
				haml_tag :li, :id => 'lc_inactive', :class => 'lc_inactive' do 
					haml_concat "Commissioner Tools"
				end
			end
		else
			nil
		end
	end
	def lc_panel
		unless @user.lc == true && @league.draft_start == false
			capture_haml do
				haml_tag :script, "$('#lc_panel').remove()"
			end
		end
	end
	def lc_tutorial
		capture_haml do
			if @user.lc == true && @user.first_visit == true
				haml_tag :div, :class => 'tutorial' do
					haml_tag :h2, "Welcome!"
					haml_tag :p, "Congratulations on starting a new league.  As the Commissioner for your new league, #{@league.name}, you have many awesome and frightful responsibilities ahead of you..."
					haml_tag :p, "Nah, just kidding, it's actually really easy to set up your league.  Just follow the instructions by clicking on 'Commissioner Tools' below."
					haml_tag :p do
						haml_concat link_to "Oh, and click here if you don't want to this box every time you log in.", first_visit_path(@user), :remote => true
						haml_tag :p, :id => 'first_visit_response', :class => 'first_visit_response'
					end
				end
				haml_concat image_tag 'down_arrow4.png', :class => 'down_arrow'				
			end
		end
	end
	def lc_overlay
		capture_haml do
			if @user.lc == true && @user.first_visit == true
				haml_tag :div, :class => 'black_overlay'
			end
		end
	end
	def other_teams
		capture_haml do
			# @usernames.each do |username|
			# 	user = User.find_by_username(username)
			# 	haml_tag :div, :id => "#{user.username}_team" do
			# 		haml_tag :h3, :class => "team_table_title" do
			# 			haml_concat user.username	
			# 		end				
			# 	end
			# end
			@users.each do |user|
				unless user == current_user
					haml_tag :div, :id => "#{user.first_name}_team" do
						haml_tag :h2, :class => "team_table_title" do
							haml_concat "#{user.first_name}'s Team"	
						end	
						haml_tag :table, :id => "contestants", :class => "contestants" do
							team = user.team
							rows = (team.length.to_f / 3).ceil
							for i in 0...rows
								haml_tag :tr do
									haml_tag :td do
										name = "#{team[(i*3)]}"
										filename = "contestants/" + name.gsub(" ", "_")+".jpg"
										haml_concat image_tag filename
										haml_tag :h3, name.gsub(/( \S*)/, "")
									end
									haml_tag :td do
										if team[(i*3)+1] != nil
											name = "#{team[(i*3)+1]}"
											filename = "contestants/" + name.gsub(" ", "_")+".jpg"
											haml_concat image_tag filename
											haml_tag :h3, name.gsub(/( \S*)/, "")
										end
									end
									haml_tag :td do
										if team[(i*3)+2] != nil
											name = "#{team[(i*3)+2]}"
											filename = "contestants/" + name.gsub(" ", "_")+".jpg"
											haml_concat image_tag filename
											haml_tag :h3, name.gsub(/( \S*)/, "")
										end
									end
								end
							end
						end			
					end
				end
			end
		end
	end
	def my_team
		capture_haml do
			haml_tag :table, :id => "contestants", :class => "contestants" do
				# haml_tag :thead, :id => "draft_table_head" do
				# 	haml_tag :th
				# 	n = @nrounds
				# 	for i in 1..n
				# 		haml_tag :th, "Round #{i}"
				# 	end
				# end
				# haml_tag :tbody, :id => "draft_table_body" do
				user = @user
				team = user.team
				rows = (team.length.to_f / 3).ceil
				for i in 0...rows
					haml_tag :tr do
						haml_tag :td do
							name = "#{team[(i*3)]}"
							filename = "contestants/" + name.gsub(" ", "_")+".jpg"
							haml_concat image_tag filename
							haml_tag :h3, name.gsub(/( \S*)/, "")
						end
						haml_tag :td do
							if team[(i*3)+1] != nil
								name = "#{team[(i*3)+1]}"
								filename = "contestants/" + name.gsub(" ", "_")+".jpg"
								haml_concat image_tag filename
								haml_tag :h3, name.gsub(/( \S*)/, "")
							end
						end
						haml_tag :td do
							if team[(i*3)+2] != nil
								name = "#{team[(i*3)+2]}"
								filename = "contestants/" + name.gsub(" ", "_")+".jpg"
								haml_concat image_tag filename
								haml_tag :h3, name.gsub(/( \S*)/, "")
							end
						end
					end
				end
			end
		end
	end
	def remaining(user)
		remaining = []
		user.team.each do |x|			
			member = Contestant.find_by_name(x)
			if member.survive == true
				remaining << 1
			end
		end
		remaining.inject{|sum,x| sum + x }

	end
	def pluralize
		if @league.scoring_system[:survive].to_i > 1
			return "Above you'll find the scoring system that your league, #{@league.name}, is using to determine how points are awarded after each elimination round.  For example, #{@league.scoring_system[:survive]} points are awarded for each contestant that survives an elimination round.  If you have 3 contestants on your team and they all survive that elimination round, you'd receive #{@league.scoring_system[:survive].to_i * 3} points.  This point system was determined by your League Commissioner, #{@lc.username}, and is set in stone after the draft takes place.  Up until that time, #{@lc.username} can make changes to the scoring system."
		else
			return "Above you'll find the scoring system that your league, #{@league.name}, is using to determine how points are awarded after each elimination round.  For example, #{@league.scoring_system[:survive]} point is awarded for each contestant that survives an elimination round.  If you have 3 contestants on your team and they all survive that elimination round, you'd receive #{@league.scoring_system[:survive].to_i * 3} points.  This point system was determined by your League Commissioner, #{@lc.username}, and is set in stone after the draft takes place.  Up until that time, #{@lc.username} can make changes to the scoring system."
		end
	end
	def meet_the_cast
		capture_haml do
			@contestants.each do |member|
				if (@contestants.index(member) % 3) == 0
					haml_tag :div, :class => 'left_col' do
						haml_tag :div, :id => member.gsub(" ", "_"), :class => 'cast_pics' do
							filename = "contestants/" + member.gsub(" ", "_") + ".jpg"
							haml_concat image_tag filename
							haml_tag :h4, member
						end
					end
				elsif (@contestants.index(member) % 3) == 1
					haml_tag :div, :class => 'center_col' do
						haml_tag :div, :id => member.gsub(" ", "_"), :class => 'cast_pics' do
							filename = "contestants/" + member.gsub(" ", "_") + ".jpg"
							haml_concat image_tag filename
							haml_tag :h4, member
						end
					end
				else
					haml_tag :div, :class => 'right_col' do
						haml_tag :div, :id => member.gsub(" ", "_"), :class => 'cast_pics' do
							filename = "contestants/" + member.gsub(" ", "_") + ".jpg"
							haml_concat image_tag filename
							haml_tag :h4, member
						end
					end
				end
			end
		end
	end
end
				

