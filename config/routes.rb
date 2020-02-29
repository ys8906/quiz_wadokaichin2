Rails.application.routes.draw do
  root 'home#root'

  # devise
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  # static_pages
  get   '/privacy', to: 'static_pages#privacy'
  get   '/form', to: 'static_pages#form'
  get   '/form/send_inquiry', to: 'static_pages#send_inquiry'

  resources :quiz_wadokaichins, only: [:show]
  post  '/quiz_wadokaichins/:id',  to: 'quiz_wadokaichins#show'
end
