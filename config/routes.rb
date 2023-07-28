Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  # root "articles#index"
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create] do
      resources :comments, only: [:new, :create]
      resources :likes, only: [:create]
    end
  end

  # get '/users', to: 'users#index', as: 'user_index'
  # get '/users', to: 'users#show', as: 'user_show'

  # Defines the root path route ("/")
  # root "articles#index"
  root "users#index"

end