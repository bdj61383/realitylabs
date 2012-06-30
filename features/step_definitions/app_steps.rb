Given /^I have reset my database\.$/ do
	system("ruby reset_db.rb")
end

Given /the following leagues exist/ do |leagues_table|
  leagues_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    League.create!(movie)
  end
  if League.all == nil
  	flunk "The leagues did not get created"
  end
end

Given /the following contestants exist/ do |contestants_table|
  contestants_table.hashes.each do |contestant|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that contestant to the database here.
    Contestant.create!(contestant)
  end
  if Contestant.all == nil
  	flunk "The contestants did not get created"
  end
end

Then /^the field "(.*?)" should be "(.*?)"$/ do |field, value|
	#{field}
	unless page.has_css?('td', :id => "#{field}", :text => "#{value}")
		flunk "This field and value weren't found."
	end
end

# Then /^I should(n't)? see movies with the following ratings: (.*)/ do |see, rating_list|
#   @ratings = rating_list.split(", ")
#   if see == nil
#     @ratings.each do |rating|
#       unless page.has_css?('html body div#main table#movies tbody#movielist tr td[2]', :text => /^#{rating}$/, :visible => true) 
#         flunk "Rating not present in your results"
#       end
#     end
#   elsif
#     @ratings.each do |rating|
#       if page.has_css?('html body div#main table#movies tbody#movielist tr td[2]', :text => /^#{rating}$/, :visible => true) 
#         flunk "Rating should not present in your results, but it is"
#       end
#     end
#   else
#     flunk "Unspecified error with your should/shouldn't see step.  Make sure you framed your question as 'should' or 'shouldn't"
#   end
# end