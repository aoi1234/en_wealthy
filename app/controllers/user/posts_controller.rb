class User::PostsController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update]

  def new
    @post = Post.new
  end

  def index
    @posts = Post.all.order(created_at: :desc)
    @user = current_user
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to user_path(@post.user_id), notice: '投稿が更新されました。'
    else
      @user = current_user
      @posts = Post.all
      flash.now[:alert] = '投稿が更新されませんでした。'
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.user
    @new_post = Post.new
    @post_comment = PostComment.new
  end

  def destroy
    post = Post.find(params[:id])
    if post.user_id == current_user.id
      post.destroy
      redirect_to posts_path(post.user_id), notice: '投稿が削除されました。'
    else
      redirect_to posts_path, notice: '自分の投稿以外削除できません'
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post.id), notice: '更新されました。'
    else
      flash[:alert] = '更新できませんでした。'
      render :edit
    end
  end


  private

  def post_params
    params.require(:post).permit(:title, :body, :industry, :category)
  end

  def ensure_correct_user
    @post = Post.find(params[:id])
    unless @post.user_id == current_user.id
      flash[:danger] = "権限がありません"
      redirect_to posts_path
    end
  end
end
