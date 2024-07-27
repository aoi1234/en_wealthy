class User::PostCommentsController < ApplicationController
  def create
    post = Post.find(params[:post_id])
    comment = current_user.post_comments.new(post_comment_params)
    comment.post_id = post.id
    if comment.save
      redirect_to request.referer, alert: 'コメントの投稿に成功しました。'
    else
      redirect_to request.referer, alert: 'コメントの投稿に失敗しました。'
    end
  end
  
  def destroy
    @comment = PostComment.find(params[:id])
    @post = @comment.post
    if @comment.user_id == current_user.id
      @comment.destroy
      redirect_to request.referer, notice: 'コメントが削除されました。'
    else
      redirect_to request.referer, alert: '他人のコメントを削除することはできません。'
    end
  end
  
  private
  
  def post_comment_params
    params.require(:post_comment).permit(:comment, :post_id)
  end
end
