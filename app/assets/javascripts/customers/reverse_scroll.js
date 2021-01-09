 /* global $*/
// 初回読み込み、リロード、ページ切り替えでturbolinksを動かす。
// $(document).on("turbolinks:load", function() {
$(function() {
  var i = 2;
  $(".chat").scrollTop(1);
  // スクロールした時に引数のfunctionを実行する
  $(".chat").scroll(function() {
    // $(".chat").scrollTop() == 0: 指定した要素のスクロール位置が0かどうか
    // parseInt(): 第1引数の文字列をパースし、第2引数に与えられた基数にもとづく整数を返す
    // $(".message_view").find("nav.pagination span.last a"): ページネーションリンクの最後のページを指すリンクを指定
    // .prop("search"): リンクのURLパラメータ(eg.?page=2)を取得
    // .match(/[0-9]/), 10): 正規表現で数字にマッチするもの(=ページ番号(e.g. 2))を取得
    if (($(".chat").scrollTop() == 0) && (i <= parseInt($(".message_view").find("nav.pagination span.last a").prop("search").match(/[0-9]/), 10))){
      $.ajax({
        url: $(".message_view").find("nav.pagination a[rel=next]").prop("search").replace(/[0-9]/, i)
      }).done(function(data) {
        $(".chat ul").prepend($(data).find(".chat ul").html());
        $(".chat").scrollTop($(".chat").first().height());
        i++;
      })
    }
  })
})