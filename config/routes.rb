Rails.application.routes.draw do
  root 'static_pages#index'
  get '/auth/github/callback', to: 'authentications#create'
  get '/auth/github', as: 'sign-in'
  get '/sign-out', to: 'authentications#destroy'

  resources :lightning_talks, only: [:index]

  resources :users, only: [] do
    resources :lightning_talks, except: [:index]
  end
end
