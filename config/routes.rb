Rails.application.routes.draw do
  root 'welcome#index'
  get '/auth/github/callback', to: 'authentications#create'
  get '/auth/github', as: 'sign-in'
  get '/sign-out', to: 'authentications#destroy'

  resources :users, only: [] do
    resources :lightning_talks, except: [:edit, :update, :destroy], module: :users
  end

  resources :days, only: [] do
    resources :lightning_talks, only: [:index], module: :days
  end
end
