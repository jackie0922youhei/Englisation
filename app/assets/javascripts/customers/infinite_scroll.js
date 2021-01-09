 /* global $*/
// 初回読み込み、リロード、ページ切り替えでturbolinksを動かす。
// $(document).on("turbolinks:load", function() {
$(function() {
  if ($("ul.pagination a[rel=next]").length){
    // コンテナ(スコープとなるセレクタ)に対し無限スクロールを実行
    $(".direct_messages").infiniteScroll({
      // 次ページへのページネーションリンクを指定
      path: "ul.pagination a[rel=next]",
      // コンテナに追加する要素の指定
      append: ".direct_messages div",
      // 無限スクロールを適用する範囲の指定。trueだとコンテナを無限スクロール範囲とする
      elementScroll: false,
      // 読み込むたびにURLを書き換えるかどうかの指定
      history: true,
      // 一番下までスクロールする前に読み込むかどうかの指定
      prefill: false,
      // 読込み中や読込み終了時に表示するものを指定
      status: ".page-load-status",
      // ページネーションリンクを表示するかどうかを指定(display: noneと同じ)
      hideNav: ".pagination"
    })
  }
})