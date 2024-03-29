Realitylabs::Application.routes.draw do
  get "log_out" => "sessions#destroy", :as => "log_out"
  get "log_in" => "sessions#new", :as => "log_in"
  get "sign_up" => "users#new", :as => "sign_up"
  get "start_league" => 'leagues#new', :as => 'start_league'
  post "leagues/:id/start_draft" => 'leagues#start_draft', :as => 'start_draft'
  get 'leagues/:id/draft' => 'leagues#draft', :as => 'draft'
  post "leagues/:id/add_to_team" => 'leagues#add_to_team', :as => 'add_to_team'  
  post "users/:id/delete_user" => 'users#delete_user', :as => 'delete_user'
  get 'users/:id/first_visit' => 'users#first_visit', :as => 'first_visit'
  post 'check_username' => 'users#check_username', :as => 'check_username'
  post 'leagues/check_league_name' => 'leagues#check_league_name', :as => 'check_league_name'
  post 'leagues/:id/end_draft' => 'leagues#end_draft', :as => 'end_draft'

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action
  match 'contestants/add_round' => 'contestants#add_round'
  match 'contestants/update_round' => 'contestants#update_round'
  match 'contestants/reverse_round' => 'contestants#reverse_round'
  match '/admin' => 'contestants#index'
  match 'leagues/:id/add_to_team' => 'leagues#add_to_team'

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products
  resources :users, :sessions, :password_resets
  resources :contestants do
    collection do
      get 'add_round'
      put 'update_round'
      get 'reverse_round'
    end
  end
  resources :leagues do
    member do
      get 'draft'
      get 'draft_preview'
    end
  end


  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
