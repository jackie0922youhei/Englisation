// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require jquery.raty.js
//= require_tree .

 /* global $*/
$(function () {
  // ①クリックイベント
  $(document).on("click", ".js-edit-post-button", function () {
    // ②一意のpostidを代入
    var postId = $(this).data('post-id');
    // ③一意のラベルを代入
    var postLabelArea = $('#js-post-label-' + postId);
    // ④一意のコメントエリアを代入
    var postTextArea = $('#js-textarea-post-' + postId);
    // ⑤一意のボタンエリアを代入
    var postButton = $('#js-post-button-' + postId);
    // ③を非表示
    postLabelArea.hide();
    // ④を表示
    postTextArea.show();
    // ⑤を表示
    postButton.show();
  });
  $(document).on("click", ".post-cancel-button", function () {
    var postId = $(this).data('cancel-id');
    var postLabelArea = $('#js-post-label-' + postId);
    var postTextArea = $('#js-textarea-post-' + postId);
    var postButton = $('#js-post-button-' + postId);
    var postError = $('#js-post-error-' + postId);
    postLabelArea.show();
    postTextArea.hide();
    postButton.hide();
    postError.hide();
  });
  $(document).on("click", ".post-update-button", function () {
    var postId = $(this).data('update-id');
    var textField = $('#js-textarea-post-' + postId);
    // ②textFieldの内容を取得
    var body = textField.val();
    $.ajax({
      url: '/posts/' + postId,
      type: 'PATCH',
      data: {
        post: {
          body: body
        }
      }
    })
    // ①ajax通信が成功した時の処理
    .done(function (data) {
      var postLabelArea = $('#js-post-label-' + postId);
      var postTextArea = $('#js-textarea-post-' + postId);
      var postButton = $('#js-post-button-' + postId);
      var postError = $('#js-post-error-' + postId);
      postLabelArea.show();
      // ③データベースにupdateされたbodyのvalueが欲しい
      postLabelArea.text(data.body);
      postTextArea.hide();
      postButton.hide();
      postError.hide();
    })
    .fail(function () {
      // ①コメントエラー用の空タグ
      var postError = $('#js-post-error-' + postId);
      // ②空タグにメッセージを書き換える
      postError.text('コメントを入力してください');
    })
  });
});