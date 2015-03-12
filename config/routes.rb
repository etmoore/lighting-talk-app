Rails.application.routes.draw do
  root 'welcome#index'
  get '/auth/github/callback', to: 'authentications#create'
  get '/auth/github', as: 'sign-in'
  get '/sign-out', to: 'authentications#destroy'

  resources :users, only: [] do
    resources :lightning_talks, except: [:destroy], module: :users
  end

  resources :days, only: [] do
    resources :lightning_talks, only: [:index, :new, :create], module: :days
  end

  namespace :admin do
    get '', to: 'dashboard#index', as: '/'
    resources :lightning_talks
  end

  resources :talk_ideas, only: [:create]
end
