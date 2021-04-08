class FavoritesController < ApplicationController
  before_action :correct_user_create, only: [:create]
  before_action :correct_user_destory, only: [:destroy]
  
  def create
    @post = Post.find(params[:post_id])
    @favorite = Favorite.new(favorite_params)
    @same_favorite = Favorite.where(user_id: current_user.id, post_id: @post.id)
    if @favorite.save
      flash[:notice] = "お気に入りされました"
      redirect_to post_path(@post.id)
    elsif @same_favorite.present?
      flash[:alert] = "すでにお気に入りされています"
      redirect_to post_path(@post.id)
    else
      flash[:alert] = "お気に入りできませんでした"
      redirect_to post_path(@post.id)
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @favorite = Favorite.find(params[:id])
    if @favorite.destroy
      flash[:notice] = "お気に入りを削除しました"
      redirect_to post_path(id: @post.id)
    else
      flash[:alert] = "お気に入りを削除できませんでした"
      redirect_to post_path(id: @post.id)
    end
  end


  private
  def favorite_params
    params.permit(:post_id).merge(user_id: current_user.id)
  end

  def correct_user_create
    if not user_signed_in?
      flash[:alert] = "お気に入り機能はログインが必要です"
      redirect_to new_user_session_path
    end
  end

  def correct_user_destory
    post = Post.find(params[:post_id])
    favorite = Favorite.find(params[:id])
    if not favorite.user_id == current_user.id
      flash[alert] = "削除できません"
      redirect_to post_path(id: @post.id)
    end
  end
end
