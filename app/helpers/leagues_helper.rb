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
end
