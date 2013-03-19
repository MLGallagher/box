Box::Application.routes.draw do

  resources :relationships, only: [:create, :destroy]
  resources :trackers, only: [:create, :destroy]
  resources :investors
  resources :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :destroy, :edit, :update, :index]
  resources :invitations, only: [:new, :create]
  resources :funds do
    member do
      get :months_edit_for
    end
  end

  resources :months do
    collection { post :import }
  end

  match '/signup/:invitation_token', to: 'users#new', as: 'signup'
  match '/highwater_mark', to: 'funds#highwater_mark'
  match '/login', to: 'sessions#new'
  match '/current', to:'months#current_month'
  match '/current_rates', to: 'months#current_month_rates'

  root to: 'funds#recent_returns'

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
  # match ':controller(/:action(/:id))(.:format)'
end