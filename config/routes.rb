Rails.application.routes.draw do
  root 'questions#index'

  get 'register', to: 'users#new'
  post 'register', to: 'users#create'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  concern :commentable do |options|
    resources :comments, options
  end

  concern :votable do |options|
    resources :votes, options
  end

  resources :questions do
    concerns :votable, only: [:create, :destroy], votable_type: 'Question'
    concerns :commentable, only: [:create], commentable_type: 'Question'
    resources :answers, only: [:create]
  end

  resources :answers, only: [:create] do
    concerns :votable, only: [:create, :destroy], votable_type: 'Answer'
    concerns :commentable, only: [:create], commentable_type: 'Answer'
  end
end
