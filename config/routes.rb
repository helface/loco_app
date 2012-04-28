LocoApp::Application.routes.draw do

  get "threads/new"

  get "threads/create"

  get "threads/show"

  get "messages/new"

  get "messages/createdestroy"

  get "messages/index"

  get "messages/show"

  get "mailbox/new"

  get "mailbox/index"

  get "mailbox/show"

  resources :users do
    member do
      get 'newmessage'
      get 'newthread'
    end
  end
  resources :sessions, only: [:new, :create, :destroy]
  resources :reviews, only: [:new, :create, :destroy]
  resources :hostprofiles, only: [:new, :create, :destroy, :edit, :update]
  resources :mailbox, only: [:create, :show]
  resources :messages, only: [:new, :index, :show, :create, :destroy]
  resources :msgthreads, only: [:create, :show, :destroy, :update]

  get "pages/home"
  get "pages/signup"
  get "pages/find"
  get "pages/about"
  get "pages/signup"
  
  
  match '/about', to: 'pages#about'
  match '/find', to: 'pages#find'
  match '/signup', to: 'users#new'
  match '/signin', to: 'sessions#new'
  match '/signout', to: 'sessions#destroy', via: :delete
  match '/becomehost', to: 'hostprofiles#new'
  match '/unbecomehost', to: 'hostprofiles#destroy', via: :delete
  match '/newthread', to: 'msgthreads#create'
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
