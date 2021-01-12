/* global $*/
$(function() {
  var nextLoadPage = 2;
  console.log('これが出てくるかな')
  $(".direct_messages").scrollTop(1);
  $(".direct_messages").scroll(function() {
    // $(".chat").scrollTop() == 0: 指定した要素のスクロール位置が0かどうか
    // parseInt(): 第1引数の文字列をパースし、第2引数に与えられた基数にもとづく整数を返す
    // $(".message_view").find("nav.pagination span.last a"): ページネーションリンクの最後のページを指すリンクを指定
    // .prop("search"): リンクのURLパラメータ(eg.?page=2)を取得
    // .match(/[0-9]/), 10): 正規表現で数字にマッチするもの(=ページ番号(e.g. 2))を取得
    if (($(".direct_messages").scrollTop() == 0) && (nextLoadPage <= parseInt($(".pagination").find("li:last a").prop('search').match(/[0-9]/), 10))){
      $.ajax({
        url: $("ul.pagination").find("a[rel=next]").prop('search').replace(/[0-9]/, nextLoadPage)
      }).done(function(data) {
        $(".direct_messages").prepend($(data).find(".direct_messages").html());
        $(".direct_messages").scrollTop($(".direct_messages").first().height());
        nextLoadPage++;
      });
    }
  });
})
