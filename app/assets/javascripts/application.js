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
//= require moment
//= require fullcalendar
//= require activestorage
/*global flatpickr*/
//= require flatpickr
//= require flatpickr/l10n/ja
//= require turbolinks
//= require_tree .

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
        eventLimit: 4,
        views: {
          dayGridMonth: {
            eventLimit: 4
          }
        },

        dayPopoverFormat: 'M/D ddd曜日',
        events: '/schedules.json',
        viewDisplay: function(view) {
        },
        windowResize: function(view) {
        },
        dayClick: function () {
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



document.addEventListener("turbolinks:load", function(){
  const TODAY = new Date(new Date().setHours(0, 0, 0, 0));
  flatpickr.localize(flatpickr.l10ns.ja);
  flatpickr('#flatpickr',{
  disableMobile: true,
  enableTime: true,
  });
});


