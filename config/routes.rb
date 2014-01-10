Autodata::Application.routes.draw do

  namespace :cpanel do
    resources :permissions
  end

  resources :resources
#  if Rails.env.development?
    get  "/images/uploads/*path" => "gridfs#serve"
#  end
  resources :nodes

  namespace :cpanel do
    resources :users
    resources :identities
  end

  get 'categories/node/:node_id' => 'categories#node', as: :nodecategory

  resources :categories do
    resources :properties
    resources :products do
      get :doing, :on => :member
      get :agree, :on => :member

      get :draft, :on => :collection
      get :ready, :on => :collection
      get :done, :on => :collection
    end
    resources :csvfiles do
      resources :pairs
      get :download, on: :member
    end
    get :getproperties, :on => :member

  end
  resources :pairs do 
    post :doing, :on => :member
    post :agree, :on => :member
    resources :products
  end

  root "sessions#new"
  post "/auth/:provider/callback", to: "sessions#create"
  get "/auth/:provider/failure", to: "sessions#failure"
  get "/logout", to: "sessions#destroy", :as => "logout"
  resources :identities

  get "manage/export" => 'cpanel/manage#export'
  get "manage/events" => 'cpanel/manage#events'

  #resources :products do
  #  resources :parameters
  #end


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
