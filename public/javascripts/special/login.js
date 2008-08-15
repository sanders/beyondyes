$(document).ready(function() {
  $("#remind_password_link").click(function() {
    window.location.href = '/special/remind_password?name_or_email=' + escape($('#name_or_email')[0].value);
    return false;
  });
  $("#signup_link").click(function() {
    window.location.href = '/special/signup?name_or_email=' + escape($('#name_or_email')[0].value);
    return false;
  });
});
