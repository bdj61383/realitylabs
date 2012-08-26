module LeaguesHelper
	def online(user)
		if user.online == true
			capture_haml do
				haml_tag :td, "#{user.username}"
			end
		else
			capture_haml do
				haml_tag :td, nil
			end
		end
	end

	def offline(user)
		if user.online == false
			capture_haml do
				haml_tag :td, "#{user.username}"
			end
		else
			capture_haml do
				haml_tag :td, nil
			end
		end
	end

	def draft_order_head
		capture_haml do
			n = @nrounds
			for i in 1..n
			  haml_tag :th, "Round #{i}"
			end
		end
	end

	def draft_order_body
		capture_haml do
			n = @nusers
			for i in 1..n
				haml_tag :tr
			end
		end
	end

	def draft_order_helper
		haml_tag :h2, "Draft Order"
		for i in 0...@nrounds
			haml_tag :div, :class => "draft_list" do
				haml_tag :h3, "Round " + (i+1).to_s
				haml_tag :ul do
					for n in 0...@nusers
						haml_tag :li, @draft_order[((@nusers*i)+n)]
					end
				end				
			end
		end
		haml_tag :div, :class => "clear"
		haml_tag :div, :class => "placeholder"
	end

	def draft_order
		capture_haml do
			if @nrounds == 1
				haml_tag :div, :class => "draft_order", :style => "width: 110px" do 
      				draft_order_helper
      			end
      		elsif @nrounds == 2 || @nrounds == 4
      			haml_tag :div, :class => "draft_order", :style => "width: 220px" do 
      				draft_order_helper
      			end
      		elsif @nrounds == 3 || @nrounds == 6
      			haml_tag :div, :class => "draft_order", :style => "width: 330px" do 
      				draft_order_helper
      			end
      		elsif @nrounds == 7 || @nrounds == 8
      			haml_tag :div, :class => "draft_order", :style => "width: 440px" do 
      				draft_order_helper
      			end      				
			elsif @nrounds == 9 || @nrounds == 10
	      		haml_tag :div, :class => "draft_order", :style => "width: 550px" do 
	      			draft_order_helper
	      		end
	      	else @nrounds > 10
	      		haml_tag :div, :class => "draft_order", :style => "width: 660px" do 
	      			draft_order_helper
	      		end
    #   			haml_tag :h2, "Draft Order"
				# for i in 0...@nrounds
				# 	haml_tag :div, :class => "draft_list" do
				# 		haml_tag :h3, "Round " + (i+1).to_s
				# 		haml_tag :ul do
				# 			for n in 0...@nusers
				# 				haml_tag :li, @draft_order[((@nusers*i)+n)]
				# 			end
				# 		end				
				# 	end
				# end
				# haml_tag :div, :class => "clear"
				# haml_tag :div, :class => "placeholder"
			end
		end
	end

	def draft_board
		capture_haml do
			haml_tag :table, :id => "draft_table", :class => "draft_table" do
				haml_tag :colgroup, :span => (@nrounds + 1)
				haml_tag :thead, :id => "draft_table_head" do
					haml_tag :tr, :class => "draft_table_header" do
						haml_tag :th, :colspan => "#{@nrounds + 1}" do 
							haml_tag :h2, "User Picks Each Round"
						end
					end
					haml_tag :tr do
						haml_tag :th do 
							haml_tag :h3, "Username"
						end
						n = @nrounds
						for i in 1..n
							haml_tag :th, :class => "draft_table_round_num" do
								haml_tag :h3, "#{i}"
							end
						end
					end
				end
				haml_tag :tbody, :id => "draft_table_body" do
					n = @nusers
					for i in 0...n
						haml_tag :tr, :id => "#{@users[i].username}_pick" do
							haml_tag :td, :class => "username" do
								haml_tag :h3, "#{@users[i].username}" 
							end 
							n = @nrounds
							for x in 0...n
								if "#{@users[i].team[x]}" == ''
									haml_tag :td 
								else 
									haml_tag :td do
										haml_concat "#{@users[i].team[x]}"
									end
								end
								# haml_tag :td
							end
						end
					end
				end
			end
		end
	end

	def contestant_pool
		capture_haml do
			@pool.each do |member|
				if (@pool.index(member) % 3) == 0
					haml_tag :div, :class => 'left_col' do
						if @league.contestant_pool[member] == true
							haml_tag :button, :id => member.gsub(" ", "_"), :class => 'available' do
								filename = "contestants/" + member.gsub(" ", "_") + ".jpg"
								haml_concat image_tag filename
								haml_tag :h4, member
							end
						else
							haml_tag :button, :id => member.gsub(" ", "_"), :class => 'unavailable' do
								filename = "contestants/" + member.gsub(" ", "_") + ".jpg"
								haml_concat image_tag filename
								haml_tag :h4, member
							end
						end
					end
				elsif (@pool.index(member) % 3) == 1
					haml_tag :div, :class => 'center_col' do
						if @league.contestant_pool[member] == true
							haml_tag :button, :id => member.gsub(" ", "_"), :class => 'available' do
								filename = "contestants/" + member.gsub(" ", "_") + ".jpg"
								haml_concat image_tag filename
								haml_tag :h4, member
							end
						else
							haml_tag :button, :id => member.gsub(" ", "_"), :class => 'unavailable' do
								filename = "contestants/" + member.gsub(" ", "_") + ".jpg"
								haml_concat image_tag filename
								haml_tag :h4, member
							end
						end
					end
				else
					haml_tag :div, :class => 'right_col' do
						if @league.contestant_pool[member] == true
							haml_tag :button, :id => member.gsub(" ", "_"), :class => 'available' do
								filename = "contestants/" + member.gsub(" ", "_") + ".jpg"
								haml_concat image_tag filename
								haml_tag :h4, member
							end
						else
							haml_tag :button, :id => member.gsub(" ", "_"), :class => 'unavailable' do
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
end
