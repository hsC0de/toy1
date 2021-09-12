/**
 * navigationBar
 */

var role = $(".userInfo_auth").text();
role = role.substring(5, role.length);
$(".userInfo_auth").text(role);

function getMenuList(upid) {

  $.ajax({
    url : '/menu/menuList',
    method : 'get',
    data : {
      upid : upid
    },
    dataType : 'json',
    success : function(menuData) {
      var str = '';
      console.log(menuData);
      for (var i = 0; i < menuData.length; i++) {
        str += '<div class="menu_list">';
        str += '<div class="menu_list_name">';
        str += '<a href="#" class="menu_list_btn">' + menuData[i].name + '</a>';
        str += '</div>';
        str += '<div class="menu_sublist">';
        for (var j = 0; j < menuData[i].submenuList.length; j++) {
          str += '<a href="' + menuData[i].submenuList[j].path;
          str += '" class="menu_sublistItem">';
          str += menuData[i].submenuList[j].name + '</a>';
        }
        str += '</div>';
        str += '</div>';
      }
      $(".navbar_menu").html(str);
    },
    error : function(error) {
      alert("menu error");
    }
  });
}

getMenuList();

$(document).on("click", ".menu_list_btn", function(e) {
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