# クライアントサイドの処理を行なうチャンネル!!
# ChannelをSubscribeしたConsumerは、Subscriberとして振る舞う

$ ->
  App.room = App.cable.subscriptions.create {channel: "RoomChannel", room: $('#direct_messages').data('room_id')},
  #通信が確立された時
  connected: ->
    # Called when the subscription is ready for use on the server
  #通信が切断された時
  disconnected: ->
    # Called when the subscription has been terminated by the server
  #値を受け取った時
  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    #投稿を追加
    # appendメソッドはhtml要素を動的に追加することができるメソッド
    $('#direct_messages').append data['direct_message']
    $('.direct_messages').animate({ scrollTop: $('.direct_messages')[0].scrollHeight });
  #サーバーサイドのspeakアクションにdirect_messageパラメータを渡す
  speak: (object) ->
    @perform 'speak', direct_message: object.content, roomId: object.roomId
$(document).on 'click','[data-behavior~=room_speaker]', (event) ->
    #speakメソッド,event.target.valueを引数に.
    roomId = document.getElementById('target').getAttribute('data-room-id')
    content = document.getElementById('content').value
    App.room.speak {roomId: roomId, content: content}
    document.getElementById('content').value = ''