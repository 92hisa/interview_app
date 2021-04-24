class TopsController < ApplicationController
  def index
    @post = Post.includes(:favorites, :user).all
    @popular_post = Post.find(Favorite.group(:post_id).order('count(post_id) desc').limit(4).pluck(:post_id))
    @recent_post = Post.order(id: "DESC").limit(4)

    # review上位４人
    has_review_userIds = Review.all.distinct.pluck(:saler_id)
    @has_review_users = User.where(id: has_review_userIds)
    average_review_users = []
    @has_review_users.each do |has_review_user|
      average_review_users << { id: has_review_user.id, average_score: has_review_user.average_review.to_s }
    end
    @popular_userIds = average_review_users.sort_by {|x| x[:average_score].reverse}.first(4).pluck(:id)
    @popular_user = User.where(id: @popular_userIds)
  end
end
