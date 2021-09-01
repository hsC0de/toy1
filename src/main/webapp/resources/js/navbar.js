/**
 * navigationBar
 */

$(".menu_list_btn").on("click", function(e) {
  e.preventDefault();
  e.stopPropagation();
  $(".menu_sublist").not($(this).parent().next()).removeClass('btn_toggle');
  $(this).parent().next().toggleClass('btn_toggle');
});
