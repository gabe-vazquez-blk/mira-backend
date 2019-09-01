Rails.application.routes.draw do

  get '/stocks', to: 'stocks#index'
  get '/stocks/:id', to: 'stocks#show'

  get '/watchlist', to: 'user_stocks#index'
  post '/add_to_watchlist/:stock_id', to: 'user_stocks#create'
  delete '/remove_from_watchlist/:stock_id', to: 'user_stocks#delete'

  get '/watchlist/:id', to: 'users#watchlist'
  get '/users', to: 'users#index'
  get '/users/:id', to: 'users#show'
  post '/signup', to: 'users#create'

  post '/login', to: 'auth#login'

  get '/auto_login', to: 'auth#auto_login'

end
