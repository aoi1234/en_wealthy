class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!
  def index
    @post = Post.new
    @posts = Post.all.order(created_at: :desc)
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
    redirect_to admin_posts_path(post.user_id), notice: '投稿が削除されました。'
  end
end
