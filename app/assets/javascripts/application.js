// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery3
//= require popper
//= require bootstrap-sprockets
//= require rails-ujs
//= require activestorage
/*global flatpickr*/
//= require flatpickr
//= require flatpickr/l10n/ja
//= require turbolinks
//= require_tree .

document.addEventListener("turbolinks:load", function(){
  flatpickr.localize(flatpickr.l10ns.ja);
  flatpickr('.flatpickr',{
    disableMobile: true,
    enableTime: true,
  });
});
// Editボタンをクリックしてモダールを開いた時にflatpickrを呼び出している
document.addEventListener("turbolinks:before-cache", function(){
$(document).on('click', '#edit-modal', function() {
  flatpickr.localize(flatpickr.l10ns.ja);
  flatpickr('.flatpickr',{
    disableMobile: true,
    enableTime: true,
  });
});
});

$(document).on('turbolinks:load', function () {
  function clearCalendar() {
    $('#calendar').html('');
  }
  $(document).on('turbolinks:before-cache', clearCalendar);
  if ($('#calendar').length) {
      $('#calendar').fullCalendar({
        height: 700,
        contentHeight: 'auto',
        aspectRatio: 1.35,
        eventLimit: true,
        views: {
          dayGridMonth: {
            eventLimit: 4
          }
        },
        dayPopoverFormat: 'M/D ddd曜日',
        events: '/schedules.json',
        eventClick: function(event) {
          if (event.url) {
            onShowModal(event.url);
            return false;
          }
        },
        eventDrop: function(info){
          // console.log(info)
          scheduleUpdatetime(info);
        },
        titleFormat: 'YYYY年 M月',
        dayNamesShort: ['日', '月', '火', '水', '木', '金', '土'],
        header: {
          left: 'prev',
          center: 'title',
          right: 'next'
        },
        defaultTimedEventDuration: '01:00:00',
        buttonText: {
          prev: '先月',
          next: '来月',
          prevYear: '前年',
          nextYear: '翌年',
          today: '今日',
          month: '月',
          week: '週',
          day: '日'
        },
        editable: true,
        eventResizableFromStart:true,
        timeFormat: "HH:mm",
        eventColor: 'gray',
        eventTextColor: '#white',
        eventRender: function(event, element) {
          element.css("font-size", "0.8em");
          element.css("padding", "0px");
          element.css("text-align", "center");
        }
      });
  }
});

function onShowModal(url){
  $.ajax({
    url: url,
    type: 'GET',
    dataType: 'html'
  })
  .done(function(data){
    /* 通信成功時 */
    $('#modalForm3').html(data);
    $('#modalForm2').modal("show");
  })
  .fail(function(data){
    /* 通信失敗時 */
    alert('通信失敗！');
  });
}

function scheduleUpdatetime(info){
  // console.log(info.start)
  var start = info.start._i[0] +'-'+ (parseInt(info.start._i[1])+1) +'-'+ info.start._i[2] + ' ' + info.start._i[3] + ':' + info.start._i[4];
  // console.log(start)
  if (info.end){
    var end = info.end._i[0] +'-'+ (parseInt(info.end._i[1])+1) +'-'+ info.end._i[2] + ' ' + info.end._i[3] + ':' + info.end._i[4];
  }else{
    var end = info.start._i[0] +'-'+ (parseInt(info.start._i[1])+1) +'-'+ info.start._i[2] + ' ' + info.start._i[3] + ':' + info.start._i[4];
  }
  var id = info.id;
  var url = '/schedules/update_datetime?id='+ id +'&start='+ start + '&end=' + end;
  $.ajax({
    url: url,
    type: 'GET',
    dataType: 'html'
  })
  .done(function(data){
  })
  .fail(function(data){
    alert('通信失敗！'); /* 通信失敗時 */
  });
}
