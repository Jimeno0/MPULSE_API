Rails.application.routes.draw do

  get '/users/:token', to: 'users#show'
  patch '/users', to: 'users#update'
  delete '/users', to: 'users#destroy'
  post '/users', to: 'users#create'
  # resources :users, only: [:destroy, :create]

end
