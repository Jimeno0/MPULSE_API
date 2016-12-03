Rails.application.routes.draw do


  post '/login',	to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  post '/register', to: 'users#create'

  patch '/users', to: 'users#update'
  delete '/users', to: 'users#destroy'

  get '/concerts/last', to: 'concerts#last'
  get '/concerts/search/:search', to: 'concerts#search'
  get '/concerts/favs/:token', to: 'concerts#index'
  get '/concerts/:token/:id', to: 'concerts#show'
end
