var gridData;

const grid = new tui.Grid({
  el : document.getElementById('grid'),
  data : gridData,
  scrollX : false,
  scrollY : false,
  columns : [ {
    header : ' ',
    name : 'seq'
  }, {
    header : '파일명',
    name : 'realName'
  }, {
    header : '등록자',
    name : 'id'
  }, {
    header : '용량',
    name : 'length'
  }, {
    header : '등록일',
    name : 'regDate'
  }, {
    header : '파일유형',
    name : 'type'
  } ]
});

tui.Grid.applyTheme('clean');

var webPath = '/';

getFileList(webPath);

function getFileList(webPath) {

  $.ajax({
    url : '/file/getFileList?webPath=' + webPath,
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

$(document).on("click", ".btn_openUploadWindow", function(e) {
  e.stopPropagation();
  e.preventDefault();
  $("input[name='uploadFile']").click();
});

$(document).on("click", ".btn_unfoldListOrDrop", function(e) {
  e.stopPropagation();
  e.preventDefault();
  $(".uploadZone").toggleClass("btn_toggle");
});

function fileReg() {
  if (confirm("등록하시겠습니까?")) {
    var form = $("#form")[0];
    var formData = new FormData(form);
    util.requestSyncFile("/file/upload", formData, "POST", "text", registResult);
  }
}
function registResult(data) {
  console.log(data);
  $("#form").load(location.href + ' #form');
  if (data.indexOf("login") != -1) {
    location.href = "/common/login";
  } else if (data == 'ok') {
    alert("업로드가 완료되었습니다.");
    getFileList(webPath);
  } else {
    alert(date);
  }
}

var obj = $(".upld_fileList");
// util.requestSync("/file/getFileList", null, "POST", "json", function(file) {
// var set = new Set();
// for (var i = 0; i < file.length; i++) {
// $("#downloadzone").append(
// "<a href='/file/getFileDownload?FILE_KEY=" + file[i].FILE_KEY + "'>" +
// file[i].FILE_REALNAME + "</a><br>\n");
// set.add(file[i].GROUP_KEY);
// }
// var array = Array.from(set);
// for (var i = 0; i < array.length; i++) {
// $("#zipzone").append("<a href='/file/getZipDownload?GROUP_KEY=" + array[i]
// + "'>" + array[i] + "</a><br>\n");
// }

// });

$(document).on("dragenter", ".upld_fileList", function(e) {
  e.stopPropagation();
  e.preventDefault();
  $(this).css('border', '1px solid #5272a0');
});
$(document).on("dragleave", ".upld_fileList", function(e) {
  e.stopPropagation();
  e.preventDefault();
  $(this).css('border', '1px dotted #8296c2');
});
$(document).on("dragover", ".upld_fileList", function(e) {
  e.stopPropagation();
  e.preventDefault();
});
$(document).on("drop", ".upld_fileList", function(e) {
  e.preventDefault();
  $(this).css('border', '1px solid #8296c2');

  var files = e.originalEvent.dataTransfer.files;
  if (files.length < 1)
    return;

  F_FileMultiUpload(files, obj);
});

function F_FileMultiUpload(files, obj) {
  if (confirm(files.length + "개의 파일을 업로드 하시겠습니까?")) {
    var data = new FormData();
    for (var i = 0; i < files.length; i++) {
      data.append('uploadFile', files[i]);
    }
    var url = "/file/upload";
    util.requestSyncFile(url, data, "POST", "text", success, error);
  }
}
function success(res) {
  if (res.indexOf("login") != -1) {
    location.href = "/common/login";
  } else if (res == 'ok') {
    alert("업로드가 완료되었습니다.");
    getFileList(webPath);
  } else {
    alert(res);
  }
  // F_FileMultiUpload_Callback(res.files);
}
function error(res) {
  alert("업로드 중에 에러가 발생했습니다. 파일은 20M를 넘을 수 없습니다.");
  console.dir(res)
}
// function F_FileMultiUpload_Callback(files) {
// for (var i = 0; i < files.length; i++) {
// var file = files[i];
// $("#downloadzone").append(
// "<a class='fileList' href='/file/getFileDownload?FILE_KEY=" + file.FILE_KEY +
// "'>" + file.FILE_REALNAME
// + "</a><br>\n");
// }
// $("#zipzone").append(
// "<a class='fileList' href='/file/getZipDownload?FILE_KEY=" + file.FILE_KEY
// + "'>" + file.FILE_KEY + "</a><br>\n");
// }
