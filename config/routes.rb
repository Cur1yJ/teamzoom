Teamzoom::Application.routes.draw do
  resources :logs

  match '/calendar(/:year(/:month))' => 'calendar#index', :as => :calendar, :constraints => {:year => /\d{4}/, :month => /\d{1,2}/}

  match '/change_date/' => 'teams#change_date', :as => :change_date

  match '/update_venue/:id' => 'teams#update_venue', :as => :update_venue, :via => :put
  match '/find_or_initial_teamsport' => 'teams#find_or_initial_teamsport'
  match 'request_installation' => 'home#request_installation', :as => :request_installation, :via => :post

  resources :orders do
    collection do
      get :term_and_service
      get :confirm
      get :failure
      get :cancel
      get :term_of_use
      post :payment_game
    end

  end

  resources :schedules
  resources :requests

  resources :conferences do
    collection do
      get :search
      get :get_conference_by_state
      get :search_admin
    end
  end



  resources :schools do
    collection do
      get :search
      get :get_school_by_conference
    end
  end

  resources :teams do
    collection do
      get :search
      get :find_team
      post :payment
      get :schedule_loading
      get :get_team_by_scholl
    end

    member do
      get :conference_directory
    end
  end
  #----------------------------------------------------------------------------
  #                     Add route for admin/team resource
  #----------------------------------------------------------------------------
  namespace :admin do
    root :to => 'teams#index'

    resource :users do
      collection do
        put :change_status
        get :index
      end

    end
    resources :states do
      member do
        put :change_status
      end
    end
    resources :conferences do
      member do
        put :change_status
      end
      collection do
        get :search_admin
      end
    end
    resources :sports do
      member do
        put :change_status
      end
    end
    resources :request_installs do
      member do
        get :index
      end
    end
    resources :school_requests do
      member do
        get :index
      end
    end
    resources :teams do
      collection do
        get :search
        get :get_conferences
      end
      #temp action to display google analytics report

      resource :users, :only => [:update_by_email,:create,:index] do
        collection do
          put :update_by_email
        end
      end
      resource :schools,:only => [:update_address] do
        put :update_address
      end
      controller :transactions do
        get :subscribers
        get :game_purchases
        get :viewers
        get :cancellations
        get :viewers_filter
        get :load_total_raise_by_time
        get :load_data_for_select
        post :send_mail_report
      end
      resources :schedules
    end
    resources :sports, :conferences

  end
  # Modify routes for ajax
  #get "load_data_for_select" => "admin/transactions#load_data_for_select"
  get "load_subteams" => "admin/schedules#load_subteams"
  get "load_teams" => "admin/schedules#load_teams"
  get "load_venues" => "admin/schedules#load_venues"
  get "load_teams_for_sport" => "admin/schedules#load_teams_for_sport"
  get "admin/users/delete_by_email" => "admin/users#delete_by_email"
  get "admin/users/change_manager_by_email" => "admin/users#change_manager_by_email"
  get "show_sport" => "teams#show_sport"
  get "load_sports_venues" => "admin/schedules#load_sports_venues"
 #----------------------------------------------------------------------------

  match '/why_teamzoom' =>  'home#why_teamzoom'
  match '/about'        =>  'home#about'
  match '/faq'          =>  'home#faq'
  match '/home_coache'          =>  'home#home_coache'
  devise_for :users, :controllers => {:registrations => "registrations", :sessions => "sessions"}
  get "teams/:id/edit" => "teams#edit"
  get "teams/conferences/search" => "conferences#search"
  get "teams/schools/search" => "schools#search"
  get "/pricing_signup" => 'home#pricing_signup'
  get "/admin" => 'home#admin'
  get "/find_team" => 'home#find_team'
  get "/home_parent" => 'home#home_parent'
  get "/team_page" => 'home#team_page'
  get "/conference" => 'home#conference'

  get "home/index" => "home#index"
  root :to => 'home#index'

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
   match ':controller(/:action(/:id))(.:format)'


end

