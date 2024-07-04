Rails.application.routes.draw do
  #devise_for :notifications
  #devise_for :relationships
  #devise_for :rooms
  #devise_for :messages
  #devise_for :entries
  #devise_for :favorites
  #devise_for :post_comments
  #devise_for :posts
  root to: 'user/homes#top'
  namespace :user do
    get 'homes/about'
  end
  # 顧客用
# URL /user/sign_in ...
devise_for :user,skip: [:passwords], controllers: {
  registrations: "user/registrations",
  sessions: 'user/sessions'
}

# 管理者用
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
