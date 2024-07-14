Rails.application.routes.draw do
  #devise_for :notifications
  #devise_for :relationships
  #devise_for :rooms
  #devise_for :messages
  #devise_for :entries
  #devise_for :favorites
  #devise_for :post_comments
  #devise_for :posts

  # 顧客用
  # URL /user/sign_in ...
  devise_for :user,skip: [:passwords], controllers: {
    registrations: 'user/registrations',
    sessions: 'user/sessions'
  }

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  #顧客用
  root to: 'user/homes#top'
  get 'home/about' => 'user/homes#about', as: 'about'
  get "/search", to: "user/searches#search"
  #get 'posts/show' => 'user/posts#show'
    scope module: :user do
      
      resources :posts, only: [:index, :new, :create, :show, :edit, :update, :destroy] do
        resources :post_comments, only: [:create, :destroy]
        resource :favorites, only: [:create, :destroy]
      end
      resources :users, only: [:index, :show, :edit, :update] do
        resource :relationships, only: [:create, :destroy]
          get "followings" => "relationships#followings", as: "followings"
          get "followers" => "relationships#followers", as: "followers"
      end
    resources :messages, only: [:create]
    resources :rooms, only: [:create,:show]
    end

  namespace :user do
    get 'homes/about'
  end

  #管理者用
  namespace :admin do
    root to: 'homes#top'
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
