Rails.application.routes.draw do
  # API routing
  scope module: 'api', defaults: {format: 'json'} do
    namespace :v1 do
      # resources :customers, only: [:index, :show]
      get 'customers', to: 'customers#index'
      get 'customers/:id', to: 'customers#show'
      get 'unshipped', to: 'unshipped#index'
      # resources :baking_list
      get 'baking_list', to: 'baking_list#index'
      # Routes for API assigment
      get 'items/:id/prices', to: 'item_prices#show'
      get 'items/:id', to: 'items#show'


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
