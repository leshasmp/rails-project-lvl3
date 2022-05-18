# frozen_string_literal: true

Rails.application.routes.draw do
  root 'home#index'
  get '/bulletins', to: 'home#index'

  post 'auth/:provider', to: 'auth#request', as: :auth_request
  get 'auth/:provider/callback', to: 'auth#callback', as: :callback_auth
  delete 'auth/logout', to: 'auth#sign_out', as: :auth_logout

  get '/profile', to: 'profile#index'

  scope 'admin' do
    get '/', to: 'admin#index', as: :admin
    resources :categories, except: %i[show]
  end

  get '/admin/bulletins', to: 'bulletins#index'

  resources :bulletins, except: %i[index destroy] do
    member do
      patch 'to_moderation'
      patch 'publish'
      patch 'reject'
      patch 'archive'
    end
  end
end
