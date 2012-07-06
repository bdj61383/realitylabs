module UsersHelper
	def lc
		if @user.lc == true
			capture_haml do
				haml_tag :li, link_to ("LC Control Box", draft_league_path(@league))
			end
		else
			nil
		end
	end
end
