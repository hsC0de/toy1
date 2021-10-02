var gridData;

const grid = new tui.Grid({
  el : document.getElementById('grid'),
  data : gridData,
  scrollX : false,
  scrollY : false,
  columns : [ {
    header : ' ',
    name : 'seq',
    width : 50,
    renderer : {
      styles : {
        'text-align' : 'center'
      }
    }
  }, {
    header : '파일명',
    name : 'realName',
    width : 500,
    renderer : {
      styles : {}
    }
  }, {
    header : '등록자',
    name : 'id',
    width : 110,
    renderer : {
      styles : {}
    }
  }, {
    header : '용량',
    name : 'length',
    width : 80,
    renderer : {
      styles : {
        'text-align' : 'center'
      }
    }
  }, {
    header : '등록일',
    name : 'regDate',
    width : 120,
    renderer : {
      styles : {
        'text-align' : 'center'
      }
    }
  },  ]
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
  $("#tempInput").click();
});

var tempFormData = new FormData();
var idx = 0;
var dataTransfer = new DataTransfer();

$(document).on("change", "#tempInput", function(e) {
  var foldBtn = $(".btn_unfoldListOrDrop");
  if($(".uploadZone").attr("class").indexOf('btn_toggle') == -1) {
    foldBtn.click();
  }  
  var tempFiles = Array.from($(this)[0].files);
  
  tempListUp(tempFiles);
  
  if(dataTransfer.items.length > 0) {
    $(".dropzoneSpan").css("display", "none");
  } else {
    $(".dropzoneSpan").css("display", "block");
  }
  
  $("#tempInput")[0].files = (new DataTransfer()).files;
});

function tempListUp(tempFiles) {
  var size = 0;
  
  for(var i = 0; i < tempFiles.length; i++) {
    dataTransfer.items.add(tempFiles[i]);
  }
  var files = dataTransfer.files;
  files = Array.from(files);
  console.log(files);
  var str = '';
  var sizeEx = 0;
  files.forEach(file => {
    size += file.size;
    if(size > 10485760) {
      dataTransfer.items.remove(dataTransfer.items.length - 1);
      sizeEx++;
      return;
    }
    str += '<li id="' + file.lastModified + '" class="file_index_' + idx + '">';
    str += '<span class="file_select">';
    str += '<label>';
    str += '<input class="checkFile" id="upld_file_' + idx + '" type="checkbox" value="' + idx + '">';
    str += '</label>';
    str += '</span>';
    str += '<span class="file_name">';
    str += '<label for="upld_file_' + idx + '">';
    if(file.type.indexOf('image') != -1) {
      str += '<span class="fic fic_img">';
    } else {
      str += '<span class="fic fic_file">';
    }
    str += '</span>';
    str += file.name;
    str += '</label>';
    str += '</span>';
    str += '<span class="file_size">' + formatSize(file.size) + '</span>';
    idx++;
    
 });
  if(sizeEx > 0) {
    alert("파일은 10M를 넘을 수 없습니다.");
  }
  $(".html_fileList").html(str);
}

$(document).on("change", ".allCheckbox_temp", function(e) {
  var checkAll = $(this);
  var checked = checkAll.prop('checked');
  $(".checkFile").prop('checked', checked);

  if($(".checkFile").prop('checked') == true) {
    $(".checkFile").closest("li").addClass("removeTarget");
  } else {
    $(".checkFile").closest("li").removeClass("removeTarget");
  }
});

$(document).on("change", ".checkFile", function() {
  if($(this).prop('checked') == true) {
    $(this).closest("li").addClass("removeTarget");
  } else {
    $(this).closest("li").removeClass("removeTarget");
  }
});

$(document).on("click", ".delete_tempList", function(e) {
  e.stopPropagation();
  e.preventDefault();
  
  var files = Array.from(dataTransfer.files);
  var tempDataTransfer = new DataTransfer();
  for(var i = 0; i < files.length; i++) {
    if($("#" + files[i].lastModified).attr("class").indexOf("removeTarget") !== -1 ) {
      $("#" + files[i].lastModified).remove();
    } else {      
      tempDataTransfer.items.add(files[i]);
    }
  }
  dataTransfer = tempDataTransfer;
  if(dataTransfer.files.length == 0) {
    $(".allCheckbox_temp").prop('checked', false);
  }
  if(dataTransfer.items.length > 0) {
    $(".dropzoneSpan").css("display", "none");
  } else {
    $(".dropzoneSpan").css("display", "block");
  }
});

function formatSize(size) {
  var resultSize = '';
  if(size > 1024 * 1024) {
    resultSize = Math.round(size / (1024 * 1024)) + 'MB';
  } else if(size > 1024) {
    resultSize = Math.round(size / 1024) + 'KB';
  } else {
    resultSize = size + 'byte';
  }
  return resultSize;
}

$(document).on("click", ".btn_unfoldListOrDrop", function(e) {
  e.stopPropagation();
  e.preventDefault();
  $(".uploadZone").toggleClass("btn_toggle");
});

function fileReg() {
  if (confirm("등록하시겠습니까?")) {
    var size = 0;
    for(var i = 0; i < dataTransfer.files.length; i++) {
      size += dataTransfer.files.size;
      if(size > 10485760) {
        $("#formFile").load(location.href + ' #formFile');
        dataTransfer = new DataTransfer();
        if(dataTransfer.items.length > 0) {
          $(".dropzoneSpan").css("display", "none");
        } else {
          $(".dropzoneSpan").css("display", "block");
        }
        alert("업로드 중에 에러가 발생했습니다. 파일은 10M를 넘을 수 없습니다.");
        return;
      }
    }
    var formData = new FormData();
    Array.from(dataTransfer.files)
         .forEach(x => {
           formData.append("uploadFile", x);
         });
    util.requestSyncFile("/file/upload", formData, "POST", "text", success, error);
  }
}
function success(data) {
  console.log(data);
  if (data.indexOf("login") != -1) {
    location.href = "/common/login";
  } else if (data == 'ok') {
    $("#formFile").load(location.href + ' #formFile');
    dataTransfer = new DataTransfer();
    if(dataTransfer.items.length > 0) {
      $(".dropzoneSpan").css("display", "none");
    } else {
      $(".dropzoneSpan").css("display", "block");
    }
    tempListUp(dataTransfer.files);
    idx = 0;
    getFileList(webPath);
    alert("업로드가 완료되었습니다.");
  } else {
    alert(date);
  }
}
function error(res) {
  alert("업로드 중에 에러가 발생했습니다. 파일은 10M를 넘을 수 없습니다.");
  console.dir(res)
}

$(document).on("dragenter", ".upld_fileList", function(e) {
  e.stopPropagation();
  e.preventDefault();
  $(this).css('border', '1px solid #5272a0');
});
$(document).on("dragleave", ".upld_fileList", function(e) {
  e.stopPropagation();
  e.preventDefault();
  $(this).css('border', '1px solid #dddddd');
});
$(document).on("dragover", ".upld_fileList", function(e) {
  e.stopPropagation();
  e.preventDefault();
});
$(document).on("drop", ".upld_fileList", function(e) {
  e.preventDefault();
  $(this).css('border', '1px solid #dddddd');

  var files = e.originalEvent.dataTransfer.files;
  if (files.length < 1)
    return;

  tempListUp(files);
});
