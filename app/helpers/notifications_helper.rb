module NotificationsHelper
  def notification_form(notification)
  visitor = link_to notification.visitor.name, notification.visitor,data: {"turbolinks" => false}, style: "color: #696969; font-weight: bold;"
  your_post = link_to 'あなたの投稿', post_path(notification), style: "color: #696969; font-weight: bold;", data: { "turbolinks" => false }
  your_dm = link_to 'メッセージ', notification.dm_room,data: {"turbolinks" => false}, style: "color: #696969; font-weight: bold;"

  case notification.action
  when "follow"
      "#{visitor}があなたをフォローしました"
  when "dm"
      "#{visitor}から#{your_dm}が届きました"
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
