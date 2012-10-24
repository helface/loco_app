require 'sidekiq/web'
require "admin_constraint"

LocoApp::Application.routes.draw do
  get "images/new"
  get "images/create"
  get "images/destroy"

  root to: "users#new"
  mount Sidekiq::Web, at: "/sidekiq"
  
  resources :users do
    resources :messages, only: [:new, :show, :create, :destroy]
    resources :reviews, only: [:new, :create, :destroy]
    resources :travelerreviews, only: [:new, :create, :destroy]
    resources :appointments do
      get :make_available
      get :cancel_appointment
      get :reject_appointment
      get :make_unavailable
      get :book_appointment
      get :complete_appointment
    end
    
    member do
      get :mailfriend
      post :mailfriend
      get :confirm
      get :update_profile_pic
    end
  end
  resources :sessions, only: [:create, :destroy]
  resources :hostprofiles, only: [:new, :create, :destroy, :edit, :update] do
     member do
       get 'deactivate'
       get 'reactivate'
    end
  end
  resources :mailbox, only: :show
  resources :languages, only: [:index]
  resources :forumposts do
    member do
      get 'respond'
      post 'create_response'
    end
  end
  resources :images, only: [:new, :create, :destroy, :show]
  resources :locations, only: [:index]
  
  get "pages/home"
  get "pages/signup"
  get "pages/find"
  get "pages/about"
  get "pages/signup"
  
  match '/about', to: 'pages#about'
  match '/hosts', to: 'pages#find'
  match '/signup', to: 'users#new'
  match '/signin', to: 'sessions#new'
  match '/signout', to: 'sessions#destroy', via: :delete
  match '/becomehost', to: 'hostprofiles#new'
  match '/unbecomehost', to: 'hostprofiles#destroy', via: :delete
  match '/newthread', to: 'msgthreads#new'
  match '/board', to: 'forumposts#index'
  match 'myposts', to: 'forumposts#manage_posts'
  match 'filter', to: 'users#filter'
  match 'fill_location', to:'locations#fill_location'
  match 'updateprofile', to:'hostprofiles#update'
  match 'meetups', to:'appointments#index'
  root :to => 'pages#home'

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

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
