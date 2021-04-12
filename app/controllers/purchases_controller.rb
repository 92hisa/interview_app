class PurchasesController < ApplicationController
  before_action :authenticate_user!

  def new
    @post = Post.find(params[:post_id])
    @purchase = Purchase.new
  end

  def create
    @post = Post.find(params[:post_id])
    @purchase = @post.purchases.new(user_id: current_user.id, post_id: @post.id, saler_id: @post.user_id, buyer_id: current_user.id)
    if @purchase.save
      @room = Room.new(id: @purchase.id, purchase_id: @purchase.id)
      if @room.save!
        flash[:notice] = "購入が完了しました"
        redirect_to root_path
      else
        flash[:alert] = "roomが開設できませんでした"
        redirect_to new_post_purchase_path
      end
    else
      flash[:alert] = "購入できませんでした"
      redirect_to new_post_purchase_path
    end
  end

  # （投稿者向け）取引一覧
  def index
    @post = Post.find(params[:post_id])
    @post_purchase = @post.purchases.includes(:user)
  end
end
