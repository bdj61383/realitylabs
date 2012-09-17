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
						haml_tag :div, :class => 'cast_bio', :id => (member.gsub(" ", "_") + "_bio") do
							# contestant = Contestant.find_by_name(member)
							# haml_tag :p do
							# 	haml_tag :strong, contestant.nickname
							# 	haml_tag :br
							# 	haml_tag :b, "Tribe"
							# 	haml_tag :span, contestant.tribe
							# 	haml_tag :br
							# 	haml_tag :b, "Age"
							# 	haml_tag :span, contestant.age
							# 	haml_tag :br
							# 	haml_tag :b, "Hometown"
							# 	haml_tag :span, contestant.hometown
							# 	haml_tag :br
							# 	haml_tag :b, "Occupation"
							# 	haml_tag :span, contestant.occupation
							# 	haml_tag :br
							# 	haml_tag :b, "Reality Labs Pre-Season Rank"
							# 	haml_tag :span, contestant.preseason_rank
							# 	haml_tag :br
							# 	haml_tag :b, "The Lab Work"
							# 	haml_tag :span, :class => 'bio_float' do 
							# 		haml_concat contestant.labwork
							# 	end
							# 	haml_tag :br
							# end
						end
					end
				elsif (@contestants.index(member) % 3) == 1
					haml_tag :div, :class => 'center_col' do
						haml_tag :div, :id => member.gsub(" ", "_"), :class => 'cast_pics' do
							filename = "contestants/" + member.gsub(" ", "_") + ".jpg"
							haml_concat image_tag filename
							haml_tag :h4, member
						end
						haml_tag :div, :class => 'cast_bio', :id => (member.gsub(" ", "_") + "_bio") do
							# contestant = Contestant.find_by_name(member)
							# haml_tag :p do
							# 	haml_tag :strong, contestant.nickname
							# 	haml_tag :br
							# 	haml_tag :b, "Tribe"
							# 	haml_tag :span, contestant.tribe
							# 	haml_tag :br
							# 	haml_tag :b, "Age"
							# 	haml_tag :span, contestant.age
							# 	haml_tag :br
							# 	haml_tag :b, "Hometown"
							# 	haml_tag :span, contestant.hometown
							# 	haml_tag :br
							# 	haml_tag :b, "Occupation"
							# 	haml_tag :span, contestant.occupation
							# 	haml_tag :br
							# 	haml_tag :b, "Reality Labs Pre-Season Rank"
							# 	haml_tag :span, contestant.preseason_rank
							# 	haml_tag :br
							# 	haml_tag :b, "The Lab Work"
							# 	haml_tag :span, :class => 'bio_float' do 
							# 		haml_concat contestant.labwork
							# 	end
							# 	haml_tag :br
							# end
						end
					end
				else
					haml_tag :div, :class => 'right_col' do
						haml_tag :div, :id => member.gsub(" ", "_"), :class => 'cast_pics' do
							filename = "contestants/" + member.gsub(" ", "_") + ".jpg"
							haml_concat image_tag filename
							haml_tag :h4, member
						end
						haml_tag :div, :class => 'cast_bio', :id => (member.gsub(" ", "_") + "_bio") do
							# contestant = Contestant.find_by_name(member)
							# haml_tag :p do
							# 	haml_tag :strong, contestant.nickname
							# 	haml_tag :br
							# 	haml_tag :b, "Tribe"
							# 	haml_tag :span, contestant.tribe
							# 	haml_tag :br
							# 	haml_tag :b, "Age"
							# 	haml_tag :span, contestant.age
							# 	haml_tag :br
							# 	haml_tag :b, "Hometown"
							# 	haml_tag :span, contestant.hometown
							# 	haml_tag :br
							# 	haml_tag :b, "Occupation"
							# 	haml_tag :span, contestant.occupation
							# 	haml_tag :br
							# 	haml_tag :b, "Reality Labs Pre-Season Rank"
							# 	haml_tag :span, contestant.preseason_rank
							# 	haml_tag :br
							# 	haml_tag :b, "The Lab Work"
							# 	haml_tag :span, :class => 'bio_float' do 
							# 		haml_concat contestant.labwork
							# 	end
							# 	haml_tag :br
							# end
						end
					end
				end
			end
		end
	end
end