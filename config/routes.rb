Rails.application.routes.draw do
  root 'home#top'
  get 'home/about'

  devise_for :users
  resources :users, only: [:index, :show, :edit, :update] do
    resource :relationships, only: [:create, :destroy]
    get :follows, on: :member # 追加
    get :followers, on: :member # 追加
    get :my_follows, on: :member # 追加
  end

  resources :books, only: [:index, :show, :edit, :create, :update, :destroy] do
    resources :book_comments, only: [:create, :edit, :update, :destroy]
    resource :favorites, only: [:create, :destroy]
  end
end
