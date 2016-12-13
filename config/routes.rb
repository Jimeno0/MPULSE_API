Rails.application.routes.draw do

  post "/login",	to: "sessions#create"
  delete "/logout",  to: "sessions#destroy"
  post "/register", to: "users#create"

  patch "/users", to: "users#update"
  delete "/users", to: "users#destroy"

  get "/concerts/last", to: "concerts#last"
  get "/concerts/search/:search", to: "concerts#search"
  get "/concerts/:token", to: "concerts#index"

  post "/concerts/add", to: "concerts#create"
  # delete "/concerts/", to: "concerts#destroy"
  delete "/concerts/:token/:concert_id", to: "concerts#destroy"


  get "/artist/:token", to: "artists#index"
  post "/artist", to: "artists#create"
  delete "/artist", to: "artists#destroy"
end
