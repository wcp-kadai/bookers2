Rails.application.routes.draw do
  root 'home#top'
  get 'home/about'

  devise_for :users
  resources :users, only: [:index, :show, :edit, :update]

  resources :books, only: [:index, :show, :edit, :create, :update, :destroy] do
    resource :book_comments, only: :create
    resource :favorites, only: [:create, :destroy]
  end
end
