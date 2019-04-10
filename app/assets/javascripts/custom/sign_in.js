clara.js_define("sign_in", {

  please_if: function () {
    var url_path = $.currentUrl().split('?')[0];
    return _.endsWith(url_path, "/session") || _.endsWith(url_path, "/sign_in")
  },

  please: function() {    

    $("#session_email").focus();

    $(window).bind("capsOn", function(event) {
        if ($("#session_password:focus").length > 0) {
            $("#capsWarning").show();
        }
    });
    $(window).bind("capsOff capsUnknown", function(event) {
        $("#capsWarning").hide();
    });
    $("#session_password").bind("focusout", function(event) {
        $("#capsWarning").hide();
    });
    $("#session_password").bind("focusin", function(event) {
        if ($(window).capslockstate("state") === true) {
            $("#capsWarning").show();
        }
    });

    $(window).capslockstate();

    function toggleEye() {
      var openedImg = "data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='24' height='24' viewBox='0 0 24 24' fill='none' stroke='currentColor' stroke-width='2' stroke-linecap='round' stroke-linejoin='round' class='feather feather-eye'%3E%3Cpath d='M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z'%3E%3C/path%3E%3Ccircle cx='12' cy='12' r='3'%3E%3C/circle%3E%3C/svg%3E%0A";
      var closedImg = "data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='24' height='24' viewBox='0 0 24 24' fill='none' stroke='currentColor' stroke-width='2' stroke-linecap='round' stroke-linejoin='round' class='feather feather-eye-off'%3E%3Cpath d='M17.94 17.94A10.07 10.07 0 0 1 12 20c-7 0-11-8-11-8a18.45 18.45 0 0 1 5.06-5.94M9.9 4.24A9.12 9.12 0 0 1 12 4c7 0 11 8 11 8a18.5 18.5 0 0 1-2.16 3.19m-6.72-1.07a3 3 0 1 1-4.24-4.24'%3E%3C/path%3E%3Cline x1='1' y1='1' x2='23' y2='23'%3E%3C/line%3E%3C/svg%3E%0A";

      var is_closed = $(".c-eye").css("background-image").indexOf("feather-eye-off") > 0

      if (is_closed) {
        $(".c-eye").css('background-image', 'url("' + openedImg + '")');
        $("#session_password").attr("type", "password");
      } else {
        $(".c-eye").css('background-image', 'url("' + closedImg + '")');
        $("#session_password").attr("type", "text");
      }

    }

    $('input.c-eye').keypress(function(e){
      e.preventDefault();
      var theCode = (e.keyCode ? e.keyCode : e.which);
      if(theCode === 13) {
        toggleEye();
      }
    });

    $("input.c-eye").on("click", function(e){
      e.preventDefault();
      toggleEye();
    });

  }

});
