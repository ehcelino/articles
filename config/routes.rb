Rails.application.routes.draw do
  resources :articles
  resources :categories
  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  resources :sessions
  resources :users
  resources :comments
  namespace :admin do
    get 'dashboard/index'
    resource :settings
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "articles#index"
  get "about", to: 'home#about'
  get "contact", to: 'home#contact'
  get "cat/:id", to: "categories#index", as: "cat"
  post "/article/:id/like", to: "articles#like", as: "like"
  # get "users", to: "users#index"
  # redireciona os erros 404
  get '*path', to: 'errors#not_found', constraints: ->(request){ !request.path.starts_with?('/assets') && !request.path.starts_with?('/images') && !request.path.starts_with?('/javascripts') && !request.path.starts_with?('/stylesheets') && !request.path.starts_with?('/rails/active_storage') }
end
