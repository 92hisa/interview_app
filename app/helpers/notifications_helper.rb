module NotificationsHelper
  def notification_form(notification)
  @comment=nil
  visitor=link_to notification.visitor.name, notification.visitor, style:"font-weight: bold;"
  your_post=link_to 'あなたの投稿', notification.post, style:"font-weight: bold;", remote: true
  case notification.action
    when "follow" then
      "#{visitor}があなたをフォローしました"
    when "favorite" then
      "#{visitor}が#{your_post}をお気に入りしました"
    when "comment" then
      @comment=Comment.find_by(id:notification.comment_id)&.comment
      "#{visitor}が#{your_post}にコメントしました"
  end
end
end
