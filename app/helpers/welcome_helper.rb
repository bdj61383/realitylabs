module WelcomeHelper
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