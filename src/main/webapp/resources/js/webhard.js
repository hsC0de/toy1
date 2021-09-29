var gridData = [ {
  id : 549731,
  name : 'Beautiful Lies',
  artist : 'Birdy',
  release : '2016.03.26',
  type : 'Deluxe',
  typeCode : '1',
  genre : 'Pop',
  genreCode : '1',
  grade : '2',
  price : 10000,
  downloadCount : 1000,
  listenCount : 5000,
}, ];

const grid = new tui.Grid({
  el : document.getElementById('grid'),
  data : gridData,
  scrollX : false,
  scrollY : false,
  columns : [ {
    header : 'Name',
    name : 'name'
  }, {
    header : 'Artist',
    name : 'artist'
  }, {
    header : 'Type',
    name : 'type'
  }, {
    header : 'Release',
    name : 'release'
  }, {
    header : 'Genre',
    name : 'genre'
  } ]
});

tui.Grid.applyTheme('clean');

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
  } else {
    alert("업로드가 완료되었습니다.");
  }
}

var obj = $("#dropzone");
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

obj.on("dragenter", function(e) {
  e.stopPropagation();
  e.preventDefault();
  $(this).css('border', '2px solid #5272a0');
});
obj.on("dragleave", function(e) {
  e.stopPropagation();
  e.preventDefault();
  $(this).css('border', '2px dotted #8296c2');
});
obj.on("dragover", function(e) {
  e.stopPropagation();
  e.preventDefault();
});
obj.on("drop", function(e) {
  e.preventDefault();
  $(this).css('border', '2px solid #8296c2');

  var files = e.originalEvent.dataTransfer.files;
  if (files.length < 1)
    return;

  // for(var i = 0; i < files.length; i++) {
  // var file = files[i];
  // console.dir(file);
  // }
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
  alert("업로드가 완료되었습니다.");
  if (res.indexOf("login") != -1) {
    location.href = "/common/login";
  } else {
    alert(data);
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

function fnAlert(e, msg) {
  e.stopPropagation();
  alert(msg);
}