Rails.application.routes.draw do
  # get 'home/index'

  resource :registration
  resource :session
  resource :password_reset
  resource :password


  # get 'home/about'
  root 'main#index'

  # Defines the root path route ("/")
  # root "posts#index"
end
