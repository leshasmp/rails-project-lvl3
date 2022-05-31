# frozen_string_literal: true

Rails.application.routes.draw do
  scope module: 'web' do
    root 'bulletins#index'

    post 'auth/:provider', to: 'auth#request', as: :auth_request
    get 'auth/:provider/callback', to: 'auth#callback', as: :callback_auth
    delete 'auth/logout', to: 'auth#logout', as: :auth_logout

    resource :profile, only: :show

    resources :bulletins, except: :destroy do
      member do
        patch 'to_moderation'
        patch 'archive'
      end
    end

    namespace 'admin' do
      get '/', to: 'home#index'
      resources :categories, except: :show
      resources :bulletins, only: :index do
        member do
          patch 'publish'
          patch 'reject'
          patch 'archive'
        end
      end
    end
  end
end
