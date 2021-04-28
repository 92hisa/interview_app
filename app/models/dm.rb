class Dm < ApplicationRecord
  belongs_to :user
  belongs_to :dm_room
  has_many :notifications, dependent: :destroy

  validates :text, presence: true
  validates :user_id, presence: true
  validates :dm_room_id, presence: true

  def create_notification_dm!(current_user, dm_id)
    # 自分以外にコメントしている人をすべて取得し、全員に通知を送る
    temp_ids = Dm.select(:user_id).where(dm_room_id: dm_room_id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_dm!(current_user, dm_id, temp_id['user_id'])
    end
    # まだ誰もコメントしていない場合は、投稿者に通知を送る
    save_notification_dm!(current_user, dm_id, user_id) if temp_ids.blank?
  end

  def save_notification_dm!(current_user, dm_id, visited_id)
    # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
    notification = current_user.active_notifications.new(
      dm_room_id: dm_room_id,
      dm_id: id,
      visited_id: visited_id,
      action: 'dm'
    )
    # 自分の投稿に対するコメントの場合は、通知済みとする
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end
end
