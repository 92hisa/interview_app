class FavoritesController < ApplicationController
  before_action :correct_user_create, only: [:create]
  before_action :correct_user_destory, only: [:destroy]

  def create
    @post = Post.find(params[:post_id])
    @favorite = Favorite.new(favorite_params)
    if params[:type] == 'tops' && @favorite.save # topページからのリクエスト＆保存できた場合
      @post.create_notification_favorite!(current_user)
      flash[:notice] = "お気に入りされました"
      redirect_to root_path
    elsif @favorite.save # showページからリクエスト＆保存できた場合
      @post.create_notification_favorite!(current_user)
      flash[:notice] = "お気に入りされました"
      redirect_to post_path(@post)
    elsif params[:type] # topページからリクエスト＆保存できなかった場合
      flash[:alert] = "お気に入りを削除できませんでした"
      redirect_to root_path
    else # showページからリクエスト＆保存できなかった場合
      flash[:alert] = "お気に入りできませんでした"
      redirect_to post_path(@post)
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @favorite = @post.favorites.find_by(user_id: current_user)
    if params[:type] == 'tops' && @favorite.destroy # topページからのリクエスト＆削除できた場合
      flash[:notice] = "お気に入りを削除しました"
      redirect_to root_path
    elsif @favorite.destroy # showページからリクエスト＆削除できた場合
      flash[:notice] = "お気に入りを削除しました"
      redirect_to post_path(id: @post)
    elsif params[:type] # topページからリクエスト＆削除できなかった場合
      flash[:alert] = "お気に入りを削除できませんでした"
      redirect_to root_path
    else # showページからリクエスト＆削除できなかった場合
      post_path(id: @post)
    end
  end

  private

  def favorite_params
    params.permit(:post_id).merge(user_id: current_user.id)
  end

  def correct_user_create
    if !user_signed_in?
      flash[:alert] = "お気に入り機能はログインが必要です"
      redirect_to new_user_session_path
    end
  end

  def correct_user_destory
    if !user_signed_in?
      flash[:alert] = "削除できませんでした"
      redirect_to root_path
    end
  end
end
