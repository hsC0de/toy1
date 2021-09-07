/**
 * navigationBar
 */

$(".menu_list_btn").on("click", function(e) {
  e.preventDefault();
  e.stopPropagation();
  $(".menu_sublist").not($(this).parent().next()).removeClass('btn_toggle');
  $(this).parent().next().toggleClass('btn_toggle');
});

$(".userInfoButton").on("click", function(e) {
  e.preventDefault();
  e.stopPropagation();
  $(".userInfo_popup").toggleClass('btn_toggle');
});

$(".logout").on("click", function(e) {
  e.preventDefault();
  e.stopPropagation();
  $("form[role='form']").submit();
});