module UsersHelper
	def lc
		if @user.lc == true
			capture_haml do
				haml_tag :li do
					haml_concat link_to "LC Control Box", draft_league_path(@league)
				end
			end
		else
			nil
		end
	end
	def team
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
							haml_tag :h4, name
						end
						haml_tag :td do
							name = "#{team[(i*3)+1]}"
							filename = "contestants/" + name.gsub(" ", "_")+".jpg"
							haml_concat image_tag filename
							haml_tag :h4, name
						end
						haml_tag :td do
							name = "#{team[(i*3)+2]}"
							filename = "contestants/" + name.gsub(" ", "_")+".jpg"
							haml_concat image_tag filename
							haml_tag :h4, name
						end
					end
				end
			end
		end
	end
end


					# n = @nusers
					# for i in 0...n
					# 	haml_tag :tr, :id => "#{@users[i].username}_pick" do
					# 		haml_tag :td do
					# 			haml_concat "#{@users[i].username}" 
					# 		end 
					# 		n = @nrounds
					# 		for x in 0...n
					# 			if "#{@users[i].team[x]}" == ''
					# 				haml_tag :td 
					# 			else 
					# 				haml_tag :td do
					# 					haml_concat "#{@users[i].team[x]}"
					# 				end
					# 			end
					# 			# haml_tag :td
					# 		end
					# 	end
					# end
				

