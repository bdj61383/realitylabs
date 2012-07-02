# This deletes any copies of the database that have been made by Contestant#rake_db_copy
@dir = Dir.entries("db").select{|x| x =~ /^round/}
@dir.each do |directory|
	system("rm -rf db/#{directory.to_s}")
end

# This deletes any migration files that have been created by User#add_column
@filename = Dir.entries("db/migrate").select{|x| x =~ /_add_user_column_round/}
@filename.each do |file|
	system("rm -f db/migrate/#{file.to_s}")
end

# This is what actually resets your entire database, by dropping everything and then rebuilding it.
system("rake db:drop")
system("rake db:migrate")
system("rake db:seed")
system("rake db:test:prepare")