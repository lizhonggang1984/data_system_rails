Rails.application.routes.draw do
  get 'posts/new'
  get 'posts/create'
  get 'login' => 'accounts#login'
  post 'create_login' => 'accounts#create_login'

  post 'posts/create'

  get 'signup' => 'accounts#signup'
  post 'create_account' => 'accounts#create_account'
  get 'account_active' => 'accounts#account_active'
  get 'update_active/:account_id' => 'accounts#update_active'

  get '/logout' => 'accounts#logout'

  get 'home/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index'
end
