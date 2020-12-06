module ApplicationHelper

  def notification_form(notification)
    @action_customer = notification.action_customer
    @comment = nil
    @action_customer_comment = notification.comment_id
    #notification.actionがfollowかlikeかcommentか
    case notification.action
      when "follow" then
        tag.a(notification.action_customer.username, href:mypage_path(@action_customer), style:"font-weight: bold;")+"があなたをフォローしました"
      when "favorite" then
        tag.a(notification.action_customer.username, href:mypage_path(@action_customer), style:"font-weight: bold;")+"が"+tag.a('あなたの投稿', href:post_path(notification.post_id), style:"font-weight: bold;")+"にいいねしました"
      when "comment" then
        @comment = Comment.find_by(id: @action_customer_comment).body
        tag.a(@action_customer.username, href:mypage_path(@action_customer), style:"font-weight: bold;")+"が"+tag.a('あなたの投稿', href:post_path(notification.post_id), style:"font-weight: bold;")+"にコメントしました"
    end
  end

  def unchecked_notifications
    @notifications = current_customer.passive_notifications.where(checked: false)
  end

end
