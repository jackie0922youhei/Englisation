class RoomChannel < ApplicationCable::Channel

  # サーバサイドの処理を行なうチャンネル!!
  # ConsumerはChannelをSubscribeし、Subscriberとして振る舞う
  # 生成されたメッセージは、ActionCable Consumerから送信されるIDに基づいて、これらのChannel Subscriber側にルーティングされる

  #接続されたとき
  def subscribed
    # stream_from "some_channel"
    # Streamは、Channelにルーティング機能を与える
    # これにより、ChannelはPublishされたコンテンツ(Broadcast)をSubscriberにルーティングできる
    # Subscription作成時に、クライアント側のパラメータをサーバー側に渡すことができる

    result = stream_from "room_channel_#{params['room']}"
    puts '==========='
    puts result
    puts '==========='
  end

  #切断されたとき
  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  # クライアントサイドから送信されたメッセージを受信する speak を用意
  # 受け取ったメッセージを、 DirectMessage モデルに保存
  def speak(data)
    puts '================================'
    puts  data.inspect
    puts  current_customer.id
    puts  Room.all.inspect
    puts '================================'
    # speakメソッドで、メッセージ内容(content)、customer_id、room_idを作成
    # data['direct_message']で受け取った発言をdirect_messagesテーブルのcontentカラムにセットしてレコードを生成
    direct_message = DirectMessage.new content: data['direct_message'], customer_id: current_customer.id, room_id: data['roomId']
    direct_message.save!
    puts 'zzzzzzzzzzzzzzzzzzzzzzzz'
    puts direct_message.errors.inspect
    puts 'zzzzzzzzzzzzzzzzzzzzzzzz'
    # DirectMessage.create! content: data['direct_message'], customer_id: current_customer.id, room_id: data['roomId']
  end
end
