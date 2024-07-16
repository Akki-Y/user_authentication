Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  root "sessions#new"
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'  
  delete 'logout', to: 'sessions#destroy', as: :logout

  get 'users/confirmation', to: 'users#confirmation', as: 'user_confirmation'

  resources :users do   
    collection do
      get :verify
    end
  end

  get 'homepage/index', to: 'homepage#index', as: 'homepage_index'
  resources :users #users/new
end
