/* global $*/
$(function() {
  var nextLoadPage = 2;
  $(".direct_messages").scrollTop(1);
  $(".direct_messages").scroll(function() {
    // $(".direct_messages").scrollTop() == 0: 指定した要素のスクロール位置が0かどうか
    // parseInt(): 第1引数の文字列をパースし、第2引数に与えられた基数(10進数)にもとづく整数を返す
    if (($(".direct_messages").scrollTop() == 0) && (nextLoadPage <= parseInt($('.direct_messages').data('total-pages'), 10))){
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
