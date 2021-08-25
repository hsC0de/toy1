console.log("Reply Module.......");

var replyService = (function() {

  function add(reply, callback, error) {
    console.log("add reply................");

    $.ajax({
      type : "post",
      url : "/replies/new",
      data : JSON.stringify(reply),
      contentType : "application/json; charset=utf-8",
      success : function(result, status, xhr) {
        if (callback) {
          callback(result);
        }
      },
      error : function(xhr, status, er) {
        if (error) {
          error(er);
        }
      }
    });
  }

  function getList(param, callback, error) {
    var bno = param.bno;
    var page = param.page || 1;

    $.getJSON("/replies/pages/" + bno + "/" + page + ".json", function(data) {
      if (callback) {
        // callback(data); //댓글 목록만 가져오는 경우
        callback(data.replyCnt, data.list); // 댓글 숫자와 목록을 가져오는 경우
      }
    }).fail(function(xhr, status, err) {
      if (error) {
        error();
      }
    });
  }

  function remove(rno, replyer, callback, error) {
    $.ajax({
      type : 'delete',
      url : '/replies/' + rno,
      data : JSON.stringify({
        rno : rno,
        replyer : replyer
      }),
      contentType : "application/json; charset=utf-8",
      success : function(deleteResult, status, xhr) {
        if (callback) {
          callback(deleteResult);
        }
      },
      error : function(xhr, status, er) {
        if (error) {
          error(er);
        }
      }
    });
  }

  function update(reply, callback, error) {
    console.log("RNO: " + reply.rno);

    $.ajax({
      type : 'put',
      url : '/replies/' + reply.rno,
      data : JSON.stringify(reply),
      contentType : "application/json; charset=utf-8",
      success : function(result, status, xhr) {
        if (callback) {
          callback(result);
        }
      },
      error : function(xhr, status, er) {
        if (error) {
          error(er);
        }
      }
    });
  }

  function get(rno, callback, error) {
    $.get("/replies/" + rno + ".json", function(result) {
      if (callback) {
        callback(result);
      }
    }).fail(function(xhr, status, err) {
      if (error) {
        error();
      }
    });
  }

  function displayTime(timeValue, gap) {
    // var today = new Date();
    // var gap = today.getTime() - timeValue;
    var gap = gap;
    var dateObj = new Date(timeValue);
    // var date = new Date(new Date().toLocaleDateString());

    var hh = dateObj.getHours();
    var mi = dateObj.getMinutes();
    var ss = dateObj.getSeconds();
    var yy = dateObj.getFullYear();
    var mm = dateObj.getMonth() + 1;
    var dd = dateObj.getDate();

    if (gap < 0) {

      return [ (hh > 9 ? '' : '0') + hh, ':', (mi > 9 ? '' : '0') + mi ].join('');
    } else {

      return [ yy, '/', (mm > 9 ? '' : '0') + mm, '/', (dd > 9 ? '' : '0') + dd ].join('');
    }

    // if (gap < 1000 * 60) {
    // return Math.floor(gap / 1000) + "초 전";
    // } else if (gap < (1000 * 60 * 60)) {
    // return Math.floor(gap / 1000 / 60) + "분 전";
    // } else if (gap < 1000 * 60 * 60 * 24) {
    // return Math.floor(gap / 1000 / 60 / 60) + "시간 전";
    // } else if (gap < 1000 * 60 * 60 * 24 * 7) {
    // return Math.floor(gap / 1000 / 60 / 60 / 24) + "일 전";
    // } else if(gap < 1000 * 60 * 60 * 24 * lastDay) {
    // return Math.floor(gap / 1000/ 60 / 60/ 24 / 7) + "주 전";
    // } else if (gap < 1000 * 60 * 60 * 24 * lastDay * 12) {
    // return Math.floor(gap / 1000 / 60 / 60 / 24 / lastDay) + "개월 전";
    // } else {
    // return Math.floor(gap / 1000 / 60 / 60 / 24 / lastDay / 12) + "년 전";
    // }

  }

  function displayTime1(timeValue) {

    var dateObj = new Date(timeValue);
    // var lastDate = new Date(dateObj.getYear(), dateObj.getMonth() + 1, 0);
    // var lastDay = lastDate.getDate();
    // console.log(lastDay);

    var hh = dateObj.getHours();
    var mi = dateObj.getMinutes();
    var ss = dateObj.getSeconds();
    var yy = dateObj.getFullYear();
    var mm = dateObj.getMonth() + 1;
    var dd = dateObj.getDate();

    return [ yy, '/', (mm > 9 ? '' : '0') + mm, '/', (dd > 9 ? '' : '0') + dd, ' ', (hh > 9 ? '' : '0') + hh, ':',
        (mi > 9 ? '' : '0') + mi ].join('');

  }
  
  function displayGap(gap) {
    var gap = gap * 1000;
    
  if (gap < 1000 * 60) {
     return Math.floor(gap / 1000) + "초 전";
     } else if (gap < (1000 * 60 * 60)) {
     return Math.floor(gap / 1000 / 60) + "분 전";
     } else if (gap < 1000 * 60 * 60 * 24) {
     return Math.floor(gap / 1000 / 60 / 60) + "시간 전";
     } else if (gap < 1000 * 60 * 60 * 24 * 7) {
     return Math.floor(gap / 1000 / 60 / 60 / 24) + "일 전";
     } else if(gap < 1000 * 60 * 60 * 24 * lastDay) {
     return Math.floor(gap / 1000/ 60 / 60/ 24 / 7) + "주 전";
     } else if (gap < 1000 * 60 * 60 * 24 * lastDay * 12) {
     return Math.floor(gap / 1000 / 60 / 60 / 24 / lastDay) + "개월 전";
     } else {
     return Math.floor(gap / 1000 / 60 / 60 / 24 / lastDay / 12) + "년 전";
     }
  }
  return {
    add : add,
    get : get,
    getList : getList,
    remove : remove,
    update : update,
    displayTime : displayTime,
    displayTime1 : displayTime1,
    displayGap : displayGap
  };

})();