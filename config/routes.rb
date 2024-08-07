Rails.application.routes.draw do
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
   devise_scope :user do
    post 'users/guest_sign_in', to: 'user/sessions#guest_sign_in'
  end

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
      resources :users, only: [:index, :show, :edit, :update, :destroy] do
        resource :relationships, only: [:create, :destroy]
          get "followings" => "relationships#followings", as: "followings"
          get "followers" => "relationships#followers", as: "followers"
      end
    resources :messages, only: [:create]
    resources :rooms, only: [:create,:show]
    resources :notifications, only: [:update]
    end

  namespace :user do
    get 'homes/about'
  end

  #管理者用
  namespace :admin do
    root to: 'homes#top'
    get 'searches/search', to: 'searches#search'

    resources :posts, only: [:index, :show, :destroy] do
      resources :post_comments, only: [:destroy]
    end
    resources :users, only: [:index, :show, :destroy]
    get 'is_celebrity/:user_id' => "users#is_celebrity", as: "is_celebrity"

  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
