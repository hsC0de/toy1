function openWritingPage(boardKind) {
  $(".board_new span").on("click", function() {

    window.open("/board/writing?kind=" + boardKind, function() {
      window.scrollTop(0);
    });
  });
}
