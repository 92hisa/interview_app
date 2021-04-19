class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :purchases
  has_many :messages
  has_many :comments
  has_many :favorites, dependent: :destroy
  has_many :reviews, dependent: :destroy

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
end
