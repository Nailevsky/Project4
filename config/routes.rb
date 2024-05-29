Rails.application.routes.draw do
  # get 'home/index'

  resource :registration
  resource :session
  resource :password_reset
  resource :password

  # Routes for games and questions
  # resources :games, only: [:index, :show] do
  #   resources :participations, only: [:new, :create, :show]
  # end
  # resources :questions, only: [:show]

  resources :games, only: [:index, :show] do
    resources :participations, only: [:create, :show]
  end

  # get 'home/about'
  root 'main#index'

  # Defines the root path route ("/")
  # root "posts#index"
end
