Rails.application.routes.draw do

  # devise
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  # static_pages
  root   'static_pages#home'
  get   '/privacy', to: 'static_pages#privacy'
  get   '/form', to: 'static_pages#form'

  resources :quiz_wadokaichins, only: [:index, :show]
  post  '/quiz_wadokaichins/:id',  to: 'quiz_wadokaichins#show'
end
