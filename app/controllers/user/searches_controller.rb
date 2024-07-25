class User::SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @model = params[:model]
    @content = params[:keyword]
    @method = params[:method]
    # 選択したモデルに応じて検索を実行
    if params[:model]  == "user"
      @records = User.search_for(params[:keyword], params[:method])
    else
      @records = Post.search_for(params[:keyword], params[:method])
    end
  end
end
