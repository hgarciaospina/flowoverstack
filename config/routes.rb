Rails.application.routes.draw do
  root 'questions#index'

  get 'register', to: 'users#new'
  post 'register', to: 'users#create'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  resources :questions do
    resources :answers, only: [:new, :create]
  end
end
