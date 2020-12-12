class DirectMessageBroadcastJob < ApplicationJob
  # queue_asメソッドは、ジョブを実行するキューの名前を指定するもの
  queue_as :default

  # performメソッドでブロードキャストを実行
  def perform(direct_message)
    # ActionCable.server.broadcastが、サーバサイドのroom_channelで登録されたコメントを、クライアントにブロードキャスト
    ActionCable.server.broadcast "room_channel_#{direct_message.room_id}", direct_message: render_direct_message(direct_message)
    # Do something later
  end

  private

  def render_direct_message(direct_message)
    # direct_messageに単純な文字列ではなく、direct_messages/direct_messagパーシャルのHTMLを返す
    ApplicationController.renderer.render partial: 'customers/direct_messages/direct_message', locals: { direct_message: direct_message }
  end

end
