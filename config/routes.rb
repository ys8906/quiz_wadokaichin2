# frozen_string_literal: true

Rails.application.routes.draw do
  # クイズ検索ページ = ホーム
  root 'quiz_wadokaichins#index'
  post '/', to: 'quiz_wadokaichins#index'

  # devise
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  # static_pages
  get   '/privacy', to: 'static_pages#privacy'
  get   '/form', to: 'static_pages#form'
  get   '/form/send_inquiry', to: 'static_pages#send_inquiry'

  resources :quiz_wadokaichins, only: [:index, :show]
  resources :quiz_wadokaichin_reactions, only: [:create]
  resources :quiz_wadokaichin_savedata, only: [:create]
  resources :user_pages, only: [:index]

  # エラー画面
  get '*path', controller: 'application', action: 'render_404'
  get '*path', controller: 'application', action: 'render_500'
end
