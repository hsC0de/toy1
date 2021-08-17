$(function() {
  $(".board_new span").on("click", function() {

    window.open("/board/writing", function() {
      window.scrollTop(0);
    });
  });
});