module NotificationsHelper
  def notification_form(notification)
  visitor = link_to notification.visitor.name, notification.visitor, style: "color: #696969; font-weight: bold;"
  your_post = link_to 'あなたの投稿', post_path(notification), style: "color: #696969; font-weight: bold;", data: { "turbolinks" => false }

  case notification.action
  when "follow"
      "#{visitor}があなたをフォローしました"
  when "favorite"
      "#{visitor}が#{your_post}をお気に入りしました"
  when "comment"
      "#{visitor}が#{your_post}にコメントしました"
  end
  end

  def unchecked_notifications
    current_user.passive_notifications.where(checked: false)
  end
end
