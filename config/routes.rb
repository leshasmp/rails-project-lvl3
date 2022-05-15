# frozen_string_literal: true

Rails.application.routes.draw do
  scope module: :web do
    root 'home#index'
    post 'auth/:provider', to: 'auth#request', as: :auth_request
    get 'auth/:provider/callback', to: 'auth#callback', as: :callback_auth
    delete 'auth/logout', to: 'auth#sign_out', as: :auth_logout

    scope 'admin' do
      get '/', to: 'admin#index', as: :admin
      resources :bulletins, only: %i[index]
      resources :categories
    end

    resources :bulletins, only: %i[show new create]
  end
end
