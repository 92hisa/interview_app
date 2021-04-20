class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :purchases
  has_many :messages
  has_many :comments
  has_many :favorites, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :relationships
  has_many :followings, through: :relationships, source: :follow
  has_many :reverse_of_relationships, class_name: 'Relatiionship', foreign_key: 'follow_id'
  has_many :followers, through: :reverse_of_relationships, source: :user

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true
  validates :about_me, length: { maximum: 500 }

  enum gender: { man: 0, woman: 1 }

  mount_uploader :profile_image, ProfileImageUploader

  def update_without_current_password(params, *options)
    if params[:password].blank? && params[:password_confirmation].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end

    result = update_attributes(params, *options)
    clean_up_passwords
    result
  end

  def post_order_recent
    Post.where(user_id: id)
  end

  def num_purchases
    Purchase.includes(:user).where(saler_id: id).count
  end

  def average_review
    reviews = Review.includes(:user).where(saler_id: id).all
    if reviews.blank?
      0
    else
      reviews.average(:score).round(1)
    end
  end

  # follow function metohod
  def follow(other_user)
    unless self == other_user
      relationships.find_or_create_by(follow_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relationship = relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end

  def following?(other_user)
    followings.include?(other_user)
  end

  def num_followers
    Relationship.where(follow_id: id).count
  end

  def num_follows
    Relationship.where(user_id: id).count
  end
end
