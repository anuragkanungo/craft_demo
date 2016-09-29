Rails.application.routes.draw do
  devise_for :users
end

Rails.application.routes.draw do
  namespace :api, constraints: { format: 'json' } do
    namespace :v1 do
      get 'tweets', to: 'tweets#index', as: 'tweets_all'
      get 'tweets/:id/remove', to: 'tweets#remove', as: 'remove_tweet'
      get 'tweets/:id', to: 'tweets#show', as: 'show_tweet'
    end
  end

  root to: 'home#index'
  get "*a", to: "application#error_page", as: 'error_page'
end
