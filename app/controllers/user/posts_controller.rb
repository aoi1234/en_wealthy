class User::PostsController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update]

  def index
    @post = Post.new
    @posts = Post.all.order(created_at: :desc)
  end

  def create

    @post = Post.new(post_params)
    @post.user_id = current_user.id

    if @post.save
      redirect_to post_path(@post)
    else
      @user = current_user
      @posts = Post.all
      flash.now[:alert] = '投稿が更新されませんでした。'
      render :index
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
    post.destroy
    redirect_to posts_path
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post.id)
    else
      flash.now[:alert] = 'updateできませんでした'
      render :edit
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :caption, :category) 
  end

  def ensure_correct_user
    post = Post.find(params[:id])
    unless post.user_id == current_user.id
      flash[:notice] = "権限がありません"
      redirect_to posts_path
    end
  end
end
