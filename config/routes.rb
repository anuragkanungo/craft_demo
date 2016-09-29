Rails.application.routes.draw do
  devise_for :users
  resources :tweets
  resources :connections


  post '/users/:followed_id/follow', to: 'connections#create', as: 'follow_user'
  post '/users/:followed_id/unfollow', to: 'connections#destroy', as: 'unfollow_user'

  root to: 'tweets#feed', as: 'home'

  get '/feed', to: 'tweets#all',format: :json, as: 'show_feed'

  get 'users/profile/:id', to: 'tweets#user', as: 'show_user_tweets'
  get 'users/followers', to: 'users#followers', as: 'show_followers'
  get 'users/following', to: 'users#following', as: 'show_following'
  get 'users/everyone', to: 'users#everyone', as: 'show_everyone'

  get "*a", to: "application#error_page", as: 'error_page'
end
