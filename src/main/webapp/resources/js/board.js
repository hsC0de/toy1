$(function() {
  $(".board_new").on("click", function() {

    window.open("/board/writing", function() {
      window.scrollTop(0);
    });
  });
});