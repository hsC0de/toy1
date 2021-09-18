function openWritingPage(boardKind) {
  $(".board_new span").on("click", function() {

    window.open("/board/writing?kind=" + boardKind, function() {
      window.scrollTop(0);
    });
  });
}

window.onpageshow = function(event) {
  if (event.persisted || (window.performance && window.performance.navigation.type == 2)) {
    location.reload();
  }
  openWritingPage(boardKind);
}