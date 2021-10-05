var util = {
  checkSession : function(url, method, param, responseType, callback, error) {
    $.ajax({
      method : method,
      url : url,
      dataType : responseType,
      data : param,
      success : callback,
      error : error
    });
  },
  requestSync : function(url, param, method, responseType, contentType, callback, error) {
    $.ajax({
      method : method,
      url : url,
      dataType : responseType,
      data : param,
      contentType : contentType,
      beforeSend : function(xhr) {
        xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
      },
      error : error,
      success : callback
    });
  },

  requestSyncFile : function(url, param, method, responseType, callback, error) {
    $.ajax({
      method : method,
      url : url,
      dataType : responseType,
      enctype : "multipart/form-data",
      processData : false,
      contentType : false,
      beforeSend : function(xhr) {
        xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
      },
      data : param,
      error : error,
      success : callback
    });
  },
  // 공통 콤보박스
  // parameter: id, groupCode, value, select, service
  // id: combo의 id와 name의 값
  // groupCode: 공통코드의 그룹코드
  // value: 기본 선택값
  // select: 전체에 해당하는 '-select-'표시 유무 Y/N
  // service: servlet을 실행할 경우 service

  initSelectBox : function(id, groupCode, value, select, service, callback) {
    if (groupCode == null)
      return;
    var reqData = {
      upcd : groupCode
    };
    var serv = "/common/getCodeList";

    if (service)
      serv = service;

    util.requestSync(serv, reqData, 'GET', 'json', function(data) {
      var obj = $('#' + id).get(0);
      obj.options.length = 0;
      if (select == "Y")
        obj.add(new Option("-select-", ""));

      for (var i = 0; i < data.codeList.length; i++) {
        var item = data.codeList[i];
        if (item.CODE == value) {
          obj.add(new Option(item.VALUE, item.CODE, true, true));
        } else {
          obj.add(new Option(item.VALUE, item.CODE));
        }
      }
    }, function(error) {
      var url = "/nosession/loginForm";
      if (callback && typeof callback == "function") {

        callback(url);
      }

    });
  }

};