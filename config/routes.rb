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
  get 'home', to: 'home#index', as: :home
  get 'contact', to: 'home#contact', as: :contact
  get 'privacy', to: 'home#privacy', as: :privacy
  get 'about',   to: 'home#about',   as: :about

  # Authentication routes
  get 'login',  to: 'sessions#new', as: :login
  post 'login',  to: 'sessions#create'
  get 'logout', to: 'sessions#destroy', as: :logout 

  get 'error_404', to: 'home#index', as: :error_404

  get 'view_cart', to: 'cart#view_cart', as: :view_cart
  get 'add_item/:id', to: 'cart#add_item', as: :add_item
  get 'remove_item/:id', to: 'cart#remove_item', as: :remove_item
  get 'empty_cart', to: 'cart#empty_cart', as: :empty_cart
  get 'checkout', to: 'cart#checkout', as: :checkout



  # Resource routes
  resources :sessions, only: [:new, :create, :destroy]
  resources :customers, except: [:destroy]
  resources :employees, except: [:destroy]
  resources :order_items, only: [:edit, :update, :destroy]
  resources :orders
  resources :addresses
  resources :items
  resources :item_prices, only: [:new, :create]

  # Cart routes

  # Search route(s)

  # You can have the root of your site routed with 'root'
end
