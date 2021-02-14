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

document.addEventListener("turbolinks:load", function(){
  const today = new Date(new Date().setHours(0, 0, 0, 0));
  flatpickr.localize(flatpickr.l10ns.ja);
  flatpickr('#flatpickr',{
  disableMobile: true,
  maxDate: today,
  });
});

// $(function () {
//   // 画面遷移を検知
//   $(document).on('turbolinks:load', function () {
//     // lengthを呼び出すことで、#calendarが存在していた場合はtrueの処理がされ、無い場合はnillを返す
//     if ($('#calendar').length) {
//       function eventCalendar() {
//         return $('#calendar').fullCalendar({
//         });
//       }
//       function clearCalendar() {
//           $('#calendar').html('');
//       }
//       $(document).on('turbolinks:load', function () {
//           eventCalendar();
//       });
//       $(document).on('turbolinks:before-cache', clearCalendar);

//       $('#calendar').fullCalendar({
//           schedules: '/schedules.json'
//       });
//     }
//   });
// });
