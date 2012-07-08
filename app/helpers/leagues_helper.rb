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
		# capture_haml do
		# 	haml_tag :table
		# 	haml_tag :thead
		# 	haml_tag :tr
		# end
		# n = @nrounds
		# for i in 1..n  
		# 	capture_haml do
		# 		haml_tag :th, "Round #{i}"
		# 	end
		# end
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
# 		%table
#   %thead
#     %tr
#       %th Signed In
#       %th Not Signed In

#   %tbody
#   - @users.each do |user|
#     %tr
#       =online(user)
#       =offline(user) 
end
