$( document ).ready(function() {

    var $that = $(".flash");
    var originalSize = $that.css('fontSize')
    $that.animate({
      fontSize: "23px"
    }, 700);
    $that.animate({
        fontSize: originalSize
    }, 700);

});
