$(document).ready(function() {
  login_widget = $("#loginWidget");
  links = login_widget.find("dt");
  forms = login_widget.find("dd");
  signup_link          = links[0];
  signup_form          = forms[0];
  login_link           = links[1];
  login_form           = forms[1];
  remind_password_link = links[2];
  remind_password_form = forms[2];

  $("#signup_password_verify")[0].value = null;

  $("#signup_name").change(function(){
    $("#login_name_or_email")[0].value = $("#signup_name")[0].value;
  });

  $("#signup_email").change(function(){
    $("#login_name_or_email")[0].value = $("#signup_email")[0].value;
    $("#remind_password_email_to_remind")[0].value = $("#signup_email")[0].value;
  });

  $("#signup_password").change(function(){
    $("#login_password")[0].value = $("#signup_password")[0].value;
  });

  $("#remind_password_email_to_remind").change(function(){
    $("#login_name_or_email")[0].value = $("#remind_password_email_to_remind")[0].value;
    $("#signup_email")[0].value = $("#remind_password_email_to_remind")[0].value;
  });

  $("#login_password").change(function(){
    $("#signup_password")[0].value = $("#login_password")[0].value;
  });

  $("#loginWidget").find("input[type=submit]").each(function () {
    $(this).after('<a href="#" class="login_cancel">cancel</a>');
  });
  $(".login_cancel").each(function() {
    $(this).click(function(){
      $(signup_link).slideDown(400);
      $(login_link).slideDown(400);
      $(remind_password_link).slideDown(400);

      $(signup_form).slideUp(400);
      $(login_form).slideUp(400);
      $(remind_password_form).slideUp(400);
      return false;
    });
  });

  $(signup_link).click(function() {
    $("#signup_password_verify")[0].value = null;
    $(signup_link).slideUp(400);
    $(login_link).slideDown(400);
    $(remind_password_link).slideDown(400);

    $(signup_form).slideDown(400);
    $(login_form).slideUp(400);
    $(remind_password_form).slideUp(400);
    return false;
  });

  $(login_link).click(function() {
    $("#signup_password_verify")[0].value = null;
    $(signup_link).slideDown(400);
    $(login_link).slideUp(400);
    $(remind_password_link).slideDown(400);

    $(signup_form).slideUp(400);
    $(login_form).slideDown(400);
    $(remind_password_form).slideUp(400);
    return false;
  });

  $(remind_password_link).click(function() {
    $("#signup_password_verify")[0].value = null;
    $(signup_link).slideDown(400);
    $(login_link).slideDown(400);
    $(remind_password_link).slideUp(400);

    $(signup_form).slideUp(400);
    $(login_form).slideUp(400);
    $(remind_password_form).slideDown(400);
    return false;
  });
});
