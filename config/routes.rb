Rails.application.routes.draw do
  resource :registration
  resource :session
  resource :password_reset
  resource :password

  resources :games, only: [:show] do
    member do
      get 'choose_player'
      post 'start_game'
    end
    resources :participations, only: [:create, :show] do
      member do
        get 'play_round'
        post 'update_round'
        post 'make_move'
        post 'restart'
      end
    end
  end

  resources :users, only: [:new, :create, :show]

  root 'main#index'
end