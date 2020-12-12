module ApplicationHelper

  def notification_form(notification)
    @action_customer = notification.action_customer

    @action_customer_comment = notification.comment_id

    @action_customer_review = notification.reciever_id
    #notification.actionがfollowかlikeかcommentかreviewか
    case notification.action
      when "follow" then
        tag.a(notification.action_customer.username, href:mypage_path(@action_customer), style:"font-weight: bold;")+"があなたをフォローしました"
      when "favorite" then
        tag.a(notification.action_customer.username, href:mypage_path(@action_customer), style:"font-weight: bold;")+"が"+tag.a('あなたの投稿', href:post_path(notification.post_id), style:"font-weight: bold;")+"にいいねしました"
      when "comment" then
        tag.a(@action_customer.username, href:mypage_path(@action_customer), style:"font-weight: bold;")+"が"+tag.a('あなたの投稿', href:post_path(notification.post_id), style:"font-weight: bold;")+"にコメントしました"
      when "review" then
        tag.a('あなたの投稿', href:post_path(notification.post_id), style:"font-weight: bold;")+"に"+tag.a(@action_customer.username, href:mypage_path(@action_customer), style:"font-weight: bold;")+"からレビューがありました"
    end
  end

  def unchecked_notifications
    @notifications = current_customer.passive_notifications.where(checked: false)
  end

end
