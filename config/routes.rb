Rails.application.routes.draw do
  devise_for :users
  resources :tweets
  resources :connections


  post '/user/:followed_id/follow', to: 'connections#create', as: 'follow_user'
  post '/user/:followed_id/unfollow', to: 'connections#destroy', as: 'unfollow_user'
  root to: 'feed#index', as: 'home'
  get '/feed/user/:id', to: 'feed#user', as: 'show_user'
  get "*a", to: "application#error_page", as: 'error_page'
end
