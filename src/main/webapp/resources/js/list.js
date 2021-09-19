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

$(document).on("click", ".sort_likes", function(e) {
  e.preventDefault();
  e.stopPropagation();

  if (!sortLike) {
    location.href = '/board/list?page=1&userDisplay=' + userDisplay + '&kind=' + boardKind + '&sortLike=true';
  } else {
    location.href = '/board/list?page=1&userDisplay=' + userDisplay + '&kind=' + boardKind;
  }
});