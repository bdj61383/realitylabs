require 'spec_helper'

describe LeaguesController do
	describe 'new league' do
		it 'should create a new league' do 
			@attr = { :name => "myleague", :confirmation_code => "mycode"}
			lambda do
          		post :create, :league => @attr
         	 	flash[:notice].should_not be_nil
        	end.should change(League, :count).by(1)
      	end

		it 'should create a new user' do 
			@attr = { :username => "myname", :password => "mypass"}
			lambda do
          		post :create, :user => @attr
         	 	flash[:notice].should_not be_nil
        	end.should change(User, :count).by(1)
      	end

		it 'should set the new user as a league commissioner with a league_id identical to the newly created league' do
			# league = double("create", :id => 5)
			# @attr = { :username => "myname", :password => "mypass"}
			# lambda do
   #        		post :create, :user => @attr
   #       	 	flash[:notice].should_not be_nil
   #      	end.should change(User, :count).by(1)

   			@league_attr = { :name => "myleague", :confirmation_code => "mycode", :id => 5}
   			@user_attr = { :username => "myname", :password => "mypass"}
			# lambda do
   #        		post :create, :user => @user_attr, :league => @league_attr
   #       	 	flash[:notice].should_not be_nil
   #      	end.should change(User, :count).by(1)

   			# league = double("create", :id => 5)
   			# user = double
   			post :create, :user => @user_attr, :league => @league_attr
   			foo = assigns(:league_id)
   			puts "League ID is #{foo}"
   			# assigns(:league_id).should eql(5)
		 
		end
	end
end

# describe MoviesController do
#   describe 'searching TMDb' do
#     before :each do
#       @fake_results = [mock('movie1'), mock('movie2')]
#     end
#     it 'should call the model method that performs TMDb search' do
#       Movie.should_receive(:find_in_tmdb).with('hardware').
#         and_return(@fake_results)
#       post :search_tmdb, {:search_terms => 'hardware'}
#     end
#     describe 'after valid search' do
#       before :each do
#         Movie.stub(:find_in_tmdb).and_return(@fake_results)
#         post :search_tmdb, {:search_terms => 'hardware'}
#       end
#       it 'should select the Search Results template for rendering' do
#         response.should render_template('search_tmdb')
#       end
#       it 'should make the TMDb search results available to that template' do
#         assigns(:movies).should == @fake_results
#       end
#     end
#   end