class ReviewsController < ApplicationController
  def new
    @post = Post.find(params[:post_id])
    @purchase = Purchase.find(params[:purchase_id])
    @review = Review.new
  end

  def create
    @post = Post.find(params[:post_id])
    @purchase = Purchase.find(params[:purchase_id])
    @review = Review.new(review_params)
    if @review.save
      flash[:notice] = "レビューが投稿されました"
      redirect_to root_path
    else
      flash[:alert] = "レビューを投稿できませんでした"
      render 'new'
    end
  end

  private
  def review_params
    params.require(:review).permit(:content, :score).merge(purchase_id: @purchase.id, saler_id: @purchase.saler_id, buyer_id: @purchase.buyer_id, user_id: current_user.id)
  end
end
