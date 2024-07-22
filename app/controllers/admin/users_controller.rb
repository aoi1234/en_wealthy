class Admin::UsersController < ApplicationController
  #before_action :authenticate_admin!
  def index
    @users = User.all
    @user = current_user
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order(created_at: :desc)
    @favorite_posts = @user.favorite_posts.order(created_at: :desc)
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    redirect_to admin_users_path
  end
end
