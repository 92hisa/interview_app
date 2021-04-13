class TopsController < ApplicationController
  def index
    @post = Post.includes(:favorites, :user).all
    @popular_post = Post.find(Favorite.group(:post_id).order('count(post_id) desc').limit(4).pluck(:post_id))
    @recent_post = Post.order(id: "DESC").limit(4)
  end
end
