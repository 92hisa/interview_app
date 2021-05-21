class RecruitmentsController < ApplicationController
  def index
    @post = Post.all.order(created_at: 'desc')
    @categories = Category.all
    @search_word = Post.ransack(params[:q])
  end
end
