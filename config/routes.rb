Rails.application.routes.draw do
  root 'home#root'
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  resources :quiz_wadokaichins, only: [:show]
  post  '/quiz_wadokaichins/:id',  to: 'quiz_wadokaichins#show'
end
