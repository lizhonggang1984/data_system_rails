Rails.application.routes.draw do
  get 'login' => 'accounts#login'
  post 'create_login' => 'accounts#create_login'

  get 'signup' => 'accounts#signup'
  post 'create_account' => 'accounts#create_account'

  get '/logout' => 'accounts#logout'

  get 'home/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index'
end
