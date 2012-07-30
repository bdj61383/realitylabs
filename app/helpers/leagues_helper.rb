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

	def draft_board
		capture_haml do
			haml_tag :table, :id => "draft_table" do
				haml_tag :thead, :id => "draft_table_head" do
					haml_tag :th
					n = @nrounds
					for i in 1..n
						haml_tag :th, "Round #{i}"
					end
				end
				haml_tag :tbody, :id => "draft_table_body" do
					n = @nusers
					for i in 0...n
						haml_tag :tr, :id => "#{@users[i].username}_pick" do
							haml_tag :td do
								haml_concat "#{@users[i].username}" 
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
			haml_tag :ul do 
				@league.contestant_pool.each do |x|
					if x[1] == true
						haml_tag :li do
							haml_tag :button, :id => "#{x[0].gsub(/ /, "_")}", :class => "available" do
								haml_concat "#{x[0]}"
							end
						end
					else
						haml_tag :li do
							haml_tag :button, :id => "#{x[0].gsub(/ /, "_")}", :class => "unavailable" do
								haml_concat "#{x[0]}"
							end
						end
					end
				end
			end
		end
	end
end
