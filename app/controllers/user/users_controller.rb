class User::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :is_matching_login_user, only: [:edit, :update]

  def index
    @users = User.all
    @user = current_user
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order(created_at: :desc)
    @favorite_posts = @user.favorite_posts.order(created_at: :desc)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to @user, notice: '更新しました!'
    else
      render edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to root_path, notice: 'またのご利用お待ちしております。'
  end

  private
  # ストロングパラメータ
  def user_params
     params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def is_matching_login_user
    @user = User.find_by(:id => params[:id])
    unless @user.id == current_user.id
    redirect_to user_path(current_user.id)
    end
  end
end
