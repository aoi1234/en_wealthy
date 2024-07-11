class User::SessionsController < Devise::SessionsController


  def after_sign_in_path_for(resource)
    posts_path
  end
  
  def destroy
    sign_out(current_user)  # セッションの論理削除（ログアウト）
    redirect_to root_path   # ログアウト後のリダイレクト先
  end
  
end
