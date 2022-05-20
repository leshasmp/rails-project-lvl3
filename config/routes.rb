# frozen_string_literal: true

Rails.application.routes.draw do
  scope module: 'web' do
    root 'bulletins#index'

    post 'auth/:provider', to: 'auth#request', as: :auth_request
    get 'auth/:provider/callback', to: 'auth#callback', as: :callback_auth
    delete 'auth/logout', to: 'auth#sign_out', as: :auth_logout

    get '/profile', to: 'profile#index'

    resources :bulletins do
      member do
        patch 'to_moderation'
        patch 'archive'
      end
    end

    resources :admin, only: :index

    namespace 'admin' do
      resources :categories, except: :show
      resources :bulletins, only: %i[index] do
        member do
          patch 'publish'
          patch 'reject'
          patch 'archive'
        end
      end
    end
  end
end
