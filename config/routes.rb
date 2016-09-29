Rails.application.routes.draw do
  devise_for :users
  resources :tweets
  resources :connections


  post '/users/:followed_id/follow', to: 'connections#create', as: 'follow_user'
  post '/users/:followed_id/unfollow', to: 'connections#destroy', as: 'unfollow_user'

  root to: 'feed#index', as: 'home'

  get 'users/profile/:id', to: 'feed#user', as: 'show_user'
  get 'users/followers', to: 'users#followers', as: 'show_followers'
  get 'users/following', to: 'users#following', as: 'show_following'
  get 'users/everyone', to: 'users#everyone', as: 'show_everyone'

  get "*a", to: "application#error_page", as: 'error_page'
end
