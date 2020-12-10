# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# クライアントサイドの処理を行なうチャンネル!!
# ChannelをSubscribeしたConsumerは、Subscriberとして振る舞う

turbolinksが下に記載してあったから、再度application.jsに記述したけれど、本当は書きたくない！！！！！！！！！！！！！！！！

document.addEventListener 'turbolinks:load', ->
  if App.room
    App.cable.subscriptions.remove App.room
  # subscriptions.createに最初の引数として渡されるオブジェクトは、Action Cableチャンネルのparamsハッシュになる
  App.room = App.cable.subscriptions.create { channel: "RoomChannel", room: $('#direct_messages').data('room_id') },
    #通信が確立された時
    connected: ->
    #通信が切断された時
    disconnected: ->
    #値を受け取った時に実行されるコールバック関数
    received: (data) ->
      #投稿を追加
      $('#direct_messages').append data['direct_message']
    #サーバーサイドのspeakアクションにdirect_messageパラメータを渡す
    speak: (direct_message) ->
      @perform 'speak', direct_message: direct_message
  # キーイベント「keypress」：キーが修飾キーでなかった場合に発生
  $('#chat-input').on 'keypress', (event) ->
    #return キーのキーコードが13
    if event.keyCode is 13
      #speakメソッド,event.target.valueを引数に.
      App.room.speak event.target.value
      event.target.value = ''
      event.preventDefault()