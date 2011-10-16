$(document).ready(function() {
  $('#generate-hash').submit(function(e){
    username = $('#username').val();
    password = $.sha1($('#password').val());
    $('#calendar-link').html('<a href="http://traktcal.matsimitsu.com/calendar.ics?username=' + username + '&password=' + password +'">http://traktcal.matsimitsu.com/calendar.ics?username=' + username + '&password=' + password +'</a>')
    $('#calendar-info').show();
    return false;
  });
});