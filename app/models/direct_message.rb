class DirectMessage < ApplicationRecord
  belongs_to :customer
  belongs_to :room
  # データが作成されたら非同期でブロードキャスト処理を実行
  # after_create_commitメソッドは、ActiveRecordのcreateまたはcreate!メソッドが呼び出されてデータベースへのコミットが正常終了した後に、
  # {}で指定したブロックが後処理として呼び出される
  # DirectMessageBroadcastJobは、perform_laterメソッドを通じて呼び出すことができる
  after_create_commit :direct_message_broadcast

  def direct_message_broadcast
    ActionCable.server.broadcast(
      "room_channel_#{room_id}",
      direct_message: render_direct_message
    )
  end

  private

  def render_direct_message
    ApplicationController.renderer.render(
      partial: 'customers/direct_messages/direct_message',
      locals: { direct_message: self }
    )
  end
end
