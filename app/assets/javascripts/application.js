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
    const postId = $(this).data('post-id');
    // ③一意のラベルを代入
    const postLabelArea = $('#js-post-label-' + postId);
    // ④一意のコメントエリアを代入
    const postTextArea = $('#js-textarea-post-' + postId);
    // ⑤一意のボタンエリアを代入
    const postButton = $('#js-post-button-' + postId);
    // ③を非表示
    postLabelArea.hide();
    // ④を表示
    postTextArea.show();
    // ⑤を表示
    postButton.show();
  });
  $(document).on("click", ".post-cancel-button", function () {
    const postId = $(this).data('cancel-id');
    const postLabelArea = $('#js-post-label-' + postId);
    const postTextArea = $('#js-textarea-post-' + postId);
    const postButton = $('#js-post-button-' + postId);
    const postError = $('#js-post-error-' + postId);
    postLabelArea.show();
    postTextArea.hide();
    postButton.hide();
    postError.hide();
  });
  $(document).on("click", ".post-update-button", function () {
    const postId = $(this).data('update-id');
    const textField = $('#js-textarea-post-' + postId);
    // ②textFieldの内容を取得
    const body = textField.val();
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
      const postLabelArea = $('#js-post-label-' + postId);
      const postTextArea = $('#js-textarea-post-' + postId);
      const postButton = $('#js-post-button-' + postId);
      const postError = $('#js-post-error-' + postId);
      postLabelArea.show();
      // ③データベースにupdateされたbodyのvalueが欲しい
      postLabelArea.text(data.body);
      postTextArea.hide();
      postButton.hide();
      postError.hide();
    })
    .fail(function () {
      // ①コメントエラー用の空タグ
      const postError = $('#js-post-error-' + postId);
      // ②空タグにメッセージを書き換える
      postError.text('コメントを入力してください');
    })
  });
});