Rails.application.routes.draw do

  get '/:token', to: 'users#show'
  patch '/users', to: 'users#update'
  resources :users, only: [:destroy, :create]

end
