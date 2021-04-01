class PurchasesController < ApplicationController

  def new
    @post = Post.find(params[:post_id])
    @purchase = Purchase.new
  end

  def create
    @post = Post.find(params[:post_id])
    @purchase = @post.purchases.new(user_id: current_user.id, post_id: @post.id)
    if @purchase.save
      flash[:notice] = "購入が完了しました"
      redirect_to root_path
    else
      flash[:alert] = "投稿に失敗しました"
      redirect_to new_post_purchase_path
    end
  end

  def show
    @post = Post.find_by(id: params[:post_id])
    @purchase = Purchase.find(id: params[:id])
  end

  def record
    purchase_logs = Purchase.where(user_id: current_user.id).pluck(:post_id)
    @purchase_logs = Post.find(purchase_logs)
  end

  def index
    @post = Post.find(params[:post_id])
    @post_purchase = @post.purchases
  end
end
