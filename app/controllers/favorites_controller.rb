class FavoritesController < ApplicationController
  before_action :require_user_logged_in
  def create
    micropost = Micropost.find(params[:micropost_id])
    current_user.put_favorite(micropost)
    flash[:success] = "お気に入りに追加しました＾＾"
    redirect_to root_url
    #renderでこのurlで表示するものはない
  end

  def destroy
    micropost = Micropost.find(params[:micropost_id])
    current_user.unput_favorite(micropost)
    flash[:success] = "お気に入りを解除しました＾＾；"
    redirect_to root_url
  end
end
