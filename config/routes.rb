Rails.application.routes.draw do


  post '/login',	to: 'sessions#create'
  delete 'logout',  to: 'sessions#destroy'

  post '/register', to: 'users#create'

  get '/users/:token', to: 'users#show'
  patch '/users', to: 'users#update'
  delete '/users', to: 'users#destroy'


  get '/concerts/last', to: 'concerts#last'
  get '/concerts/:search', to: 'concerts#search'
end
