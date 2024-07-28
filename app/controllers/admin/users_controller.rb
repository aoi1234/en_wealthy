class Admin::UsersController < ApplicationController
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

  def is_celebrity
    user = User.find(params[:user_id])
      if user.is_celebrity == true
        user.is_celebrity = false
      else
        user.is_celebrity = true
      end
    user.password = user.password
    user.save!
    redirect_to admin_user_path(params[:user_id])
  end
end
