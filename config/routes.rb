Rails.application.routes.draw do

  get '/:user_name', to: 'users#show'
  patch '/:user_name', to: 'users#update'
  resources :users, only: [:destroy, :create]

end
