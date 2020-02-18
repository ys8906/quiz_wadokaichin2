Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  root   'static_pages#home'
  resources :quiz_wadokaichins, only: [:show]
end
