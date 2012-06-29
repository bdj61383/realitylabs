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