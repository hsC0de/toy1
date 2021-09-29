var gridData;
var kind = 'BN';

getBoardList("BN")

$(document).on("click", ".dashBoard_tabs_listItem", function(e) {
  e.preventDefault();
  e.stopPropagation();
  var obj = $(this).children("a").eq(0);

  obj.closest(".dashBoard_tabs_list").children(".dashBoard_tabs_listItem").removeClass("selected_tab");
  obj.closest(".dashBoard_tabs_listItem").addClass("selected_tab");

  kind = obj.attr("href");

  getBoardList(kind, obj);

});

function getBoardList(kind, obj) {

  $.ajax({
    url : '/board/dashBoard?kind=' + kind,
    method : 'get',
    dataType : 'json',
    success : function(res) {
      console.log(res);
      // gridData = res;
      grid.resetData(eval(res));
    },
    error : function(error) {
      console.log(error);
      alert(error.status);
    }
  });
}

const grid = new tui.Grid({
  el : document.getElementById('grid'),
  data : gridData,
  scrollX : false,
  scrollY : false,
  columns : [ {
    header : ' ',
    name : 'bno',
    width : 50,
    renderer : {
      styles : {
        'text-align' : 'center'
      }
    }
  }, {
    header : '제목',
    name : 'title',
    className : 'gridColumn',
    width : 600,
    renderer : {
      styles : {
        'font-size' : '15px'
      }
    }
  }, {
    header : '작성일',
    name : 'reg_date',
    renderer : {
      styles : {
        'font-size' : '15px',
        'text-align' : 'center'
      }
    }
  } ]
});

tui.Grid.applyTheme('clean', {

  cell : {
    header : {
      background : '#fff',
      showVerticalBorder : false
    },
    normal : {
      background : '#fff',
      showHorizontalBorder : true
    }
  }
});

grid.on('click', function(ev) {
  var path = ev.nativeEvent.path[2].innerText;
  console.log(path.substring(0, path.indexOf('\n\t\n')));
  var bno = path.substring(0, path.indexOf('\n\t\n'));
  location.href = '/board/get?bno=' + bno + '&page=1&userDisplay=15&kind=' + kind;
});

// grid.hideColumn('bno');
