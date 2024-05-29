Rails.application.routes.draw do
  resource :registration, only: [:new, :create, :edit, :update, :destroy]
  resource :session, only: [:new, :create, :destroy]
  resource :password_reset, only: [:new, :create, :edit, :update]
  resource :password, only: [:edit, :update]

  resources :games, only: [:index, :show] do
    resources :participations, only: [:create, :show]
  end

  resources :questions, only: [:show]
  resources :answers, only: [:create]
  resources :users, only: [:new, :create]

  root 'main#index'
end