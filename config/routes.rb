Rails.application.routes.draw do
  # API routing
  scope module: 'api', defaults: { format: 'json' } do
    namespace :v1 do
      get 'customers', to: 'customers#index'

      get 'orders/baking_list', to: 'orders#baking_list'
      get 'orders/unshipped', to: 'orders#unshipped'

      get 'items/:id', to: 'items#show'
      get 'items/:id/prices', to: 'item_prices#show'
    end
  end
  
  # Routes for regular HTML views go here...
  # Semi-static page routes
  
  # Authentication routes
  
  # Resource routes (maps HTTP verbs to controller actions automatically):
  
  # Cart routes
  
  # Search route(s)
  
  # You can have the root of your site routed with 'root'
  
end
