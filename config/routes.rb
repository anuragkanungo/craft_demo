Rails.application.routes.draw do
  devise_for :users
  resources :tweets

  root to: 'home#index', as: 'home'
  get "*a", to: "application#error_page", as: 'error_page'
end
