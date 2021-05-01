class Post < ApplicationRecord
  belongs_to :user
  has_many :purchases
  has_many :comments
  has_many :favorites, dependent: :destroy
  has_many :post_category_relations
  has_many :categories, through: :post_category_relations
  has_many :notifications, dependent: :destroy

  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 30 }
  validates :subtitle, presence: true, length: { maximum: 200 }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 500, less_than_or_equal_to: 1000000 }
  validates :experience, presence: true, length: { maximum: 500 }
  validates :detail, length: { maximum: 1000 }

  mount_uploader :plan_image, ProfileImageUploader

  def tax
    (price * 1.1).floor.to_s(:delimited)
  end

  def display_price
    price.floor.to_s(:delimited) + "円"
  end

  def same_favorite(user)
    Favorite.find_by(user_id: user.id, post_id: id)
  end

  def favorite_count
    Favorite.where(post_id: id).count
  end

  # notifications method
  def create_notification_favorite!(current_user)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and post_id = ? and action = ?", current_user.id, user_id, id, 'like'])
    if temp.blank?
      notification = current_user.active_notifications.new(
        post_id: id,
        visited_id: user_id,
        action: 'favorite'
      )
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end

  def create_notification_comment!(current_user, comment_id)
    temp_ids = Comment.select(:user_id).where(post_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment!(current_user, comment_id, temp_id['user_id'])
    end
      save_notification_comment!(current_user, comment_id, user_id) if temp_ids.blank?
  end

  def save_notification_comment!(current_user, comment_id, visited_id)
    notification = current_user.active_notifications.new(
      post_id: id,
      comment_id: comment_id,
      visited_id: visited_id,
      action: 'comment'
    )
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end
end
