class RoomChannel < ApplicationCable::Channel
  #接続されたとき
  def subscribed
    # stream_from "some_channel"
    stream_from "room_channel_#{params['room']}"
  end

  #切断されたとき
  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    # speakメソッドで、メッセージ内容(content)、customer_id、room_idを作成
    DirectMessage.create! content: data['direct_message'], customer_id: current_customer.id, room_id: params['room']
  end
end
